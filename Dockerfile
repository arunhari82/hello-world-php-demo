FROM registry.access.redhat.com/ubi9/php-81:1-40
ENV APP_HOME /opt/app-root/src

COPY . $APP_HOME
RUN TEMPFILE=$(mktemp) && \
    curl -o "$TEMPFILE" "https://getcomposer.org/installer" && \
    php <"$TEMPFILE" && \
    ./composer.phar install --no-interaction --no-ansi --optimize-autoloader

USER 0
RUN chgrp -R 0 ${APP_HOME} && \
    chmod -R g=u ${APP_HOME}

# Start and Expose Apache.
EXPOSE 8080
USER 1001


CMD /usr/libexec/s2i/run