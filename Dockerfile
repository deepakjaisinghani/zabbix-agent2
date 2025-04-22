FROM zabbix/zabbix-agent:7.0.6-alpine

USER root

# Install ODBC and network tools
RUN apk update && \
    apk add --no-cache \
      unixodbc \
      freetds \
      iputils \
      busybox-extras  # includes telnet

# Copy custom config if needed
COPY odbc.ini /etc/odbc.ini
COPY odbcinst.ini /etc/odbcinst.ini

RUN chown zabbix:zabbix /etc/odbc.ini /etc/odbcinst.ini
USER zabbix

