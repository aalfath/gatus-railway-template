# Gatus v5.38.0 with its configuration taken from the GATUS_CONFIG environment variable.
FROM twinproduction/gatus:v5.38.0@sha256:085ed63da963728965d00a3c78aa6167e3bf135218485b893201758e079e8415 AS gatus

FROM alpine:3.24.4@sha256:f59abe656b692d901e184be3445e084786602108599d2a51d229c0f5a48c71bf
RUN apk add --no-cache ca-certificates su-exec tini \
 && adduser -D -H -u 10001 gatus \
 && mkdir -p /config /data && chown gatus:gatus /config /data
COPY --from=gatus /gatus /usr/local/bin/gatus
COPY config.yaml /etc/gatus/default.yaml
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENV GATUS_CONFIG_PATH=/config/config.yaml
EXPOSE 8080
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/entrypoint.sh"]
