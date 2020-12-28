FROM monstrenyatko/mdns-repeater AS mdns-repeater-image

FROM monstrenyatko/alpine

LABEL maintainer="Oleg Kovalenko <monstrenyatko@gmail.com>"

# install mdns-repeater
COPY --from=mdns-repeater-image /bin/mdns-repeater /bin/mdns-repeater
RUN chown root:root /bin/mdns-repeater
RUN chmod 0755 /bin/mdns-repeater
RUN setcap cap_net_raw=+ep /bin/mdns-repeater

# install
RUN apk add supervisor iptables ip6tables wireguard-tools && \
    # clean-up
    rm -rf /root/.cache && mkdir -p /root/.cache && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*

# remove sysctls call from the wg-quick script to avoid `--privilege` option
# required run option `--sysctls net.ipv4.conf.all.src_valid_mark=1` to keep same functionality
COPY wg-quick.patch /
RUN buildDeps='patch'; \
    apk add $buildDeps && \
    patch --verbose -p0 < /wg-quick.patch && \
    # clean-up
    apk del $buildDeps && \
    rm -rf /root/.cache && mkdir -p /root/.cache && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*

ENV APP_NAME="wg-server-app" \
    SYS_USERNAME="daemon" \
    SYS_GROUPNAME="daemon" \
    LOG_LEVEL=info

COPY conf.d /app/conf.d
COPY run.sh run-wg-server.sh supervisord.conf /app/
RUN chown -R root:root /app
RUN chmod -R 0644 /app
RUN find /app -type d -exec chmod 0755 {} \;
RUN find /app -type f -name '*.sh' -exec chmod 0755 {} \;

ENTRYPOINT ["/app/run.sh"]
CMD ["wg-server-app"]
