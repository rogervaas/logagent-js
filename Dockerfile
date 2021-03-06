FROM node:6-alpine

ENV LOG_URL="https://logsene-receiver.sematext.com"

RUN \
  apk add --update bash tini && \
  rm -rf /var/cache/apk/*

RUN \
  npm install -g @sematext/logagent && \
  mkdir -p /etc/sematext && \
  rm -rf /tmp/*

COPY patterns.yml /opt/logagent/patterns.yml
COPY run.sh /run.sh
RUN chmod +x /run.sh

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/run.sh"]