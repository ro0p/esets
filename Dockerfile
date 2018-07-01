FROM debian:stable-slim AS build
LABEL imagename="esets"
ARG AV_USERNAME
ARG AV_PASSWORD
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y wget libc6-i386 ed
RUN wget -q http://$AV_USERNAME:$AV_PASSWORD@download.eset.com/download/unix/esets.amd64.deb.bin -O /tmp/esets.bin 2>/dev/null && \
    sh /tmp/esets.bin  --skip-license

FROM debian:stable-slim
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y wget libc6-i386 ed procps net-tools rsyslog libcrypto++6 supervisor libssl1.0.*
COPY --from=build /etc/opt/eset /etc/opt/eset
COPY --from=build /etc/opt/eset /root/default/eset
COPY --from=build /opt/eset /opt/eset
COPY --from=build /var/opt/eset /var/opt/eset
COPY bin/* /usr/local/bin/
COPY etc/* /etc/

CMD ["esets-srv"]
