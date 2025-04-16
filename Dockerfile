FROM alpine:latest

RUN useradd --create-home --shell /bin/bash --uid 1001 --user-group dcmcsrv

ADD --chown=dcmcsrv:dcmcsrv files/Entrypoint.sh /
ADD --chown=dcmcsrv:dcmcsrv files/DeceasedCraft_Server_v5.5.5.zip /etc/DeceasedCraft/

RUN apk add --no-cache openjdk21 \
&&  unzip /etc/DeceasedCraft/DeceasedCraft_Server_v5.5.5.zip \
&&  chown -R dcmcsrv:dcmcsrv /etc/DeceasedCraft/

ENTRYPOINT [ "/Entrypoint.sh" ]