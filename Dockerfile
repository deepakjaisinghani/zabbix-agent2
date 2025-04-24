FROM zabbix/zabbix-proxy-sqlite3:7.0.6-alpine

USER root

# Install ODBC and PostgreSQL ODBC driver
RUN apk update && \
    apk add --no-cache \
        unixodbc \
        psqlodbc \
        sqlite \
        iputils \
        busybox-extras \
        curl \
        bash

# Copy ODBC configuration
COPY odbc.ini /etc/odbc.ini
COPY odbcinst.ini /etc/odbcinst.ini

# Set ownership
RUN chown zabbix:zabbix /etc/odbc.ini /etc/odbcinst.ini

# Expose volume for Zabbix DB
VOLUME ["/var/lib/zabbix"]

# Optional: Include entrypoint script if needed
# COPY docker-entrypoint.sh /usr/local/bin/
# RUN chmod +x /usr/local/bin/docker-entrypoint.sh

USER zabbix

# Default command (can be overridden)
CMD ["zabbix_proxy", "-f", "-c", "/etc/zabbix/zabbix_proxy.conf"]
