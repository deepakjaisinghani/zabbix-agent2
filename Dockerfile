FROM zabbix/zabbix-proxy-sqlite3:7.0.6-alpine

USER root

# Install ODBC and network tools
RUN apk update && \
    apk add --no-cache \
      unixodbc \
      psqlodbc \
      sqlite \
      freetds \
      iputils \
      busybox-extras \
      curl \
      bash

# You can remove these two lines now since ConfigMap will mount them
# COPY odbc.ini /etc/odbc.ini
# COPY odbcinst.ini /etc/odbcinst.ini

# Optional: create empty files so mount points exist
RUN touch /etc/odbc.ini /etc/odbcinst.ini && \
    chown zabbix:zabbix /etc/odbc.ini /etc/odbcinst.ini

USER zabbix
