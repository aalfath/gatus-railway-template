# Gatus v5.37.0 with its configuration taken from the GATUS_CONFIG environment variable.
FROM twinproduction/gatus:v5.37.0@sha256:094eb186e55235db367e90e9d56140e5897b7044c41de23cde4cc18e6da1242e AS gatus

FROM alpine:3.24.2@sha256:294b683cb724975bec92580e1e685676bd4b50bda910ddb8c51d4cabeaec77e6
RUN apk add --no-cache ca-certificates su-exec tini \
 && adduser -D -H -u 10001 gatus \
 && mkdir -p /config /data && chown gatus:gatus /config /data
COPY --from=gatus /gatus /usr/local/bin/gatus
COPY config.yaml /etc/gatus/default.yaml
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENV GATUS_CONFIG_PATH=/config/config.yaml
EXPOSE 8080
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/entrypoint.sh"]
