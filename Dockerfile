FROM alpine:latest

# user-creation
RUN addgroup --gid 1001 dcmcsrv \
&&  mkdir /home/dcmcsrv/ \
&&  adduser --home /home/dcmcsrv --disabled-password --shell /bin/bash -G dcmcsrv -u 1001 dcmcsrv

# Adding entrypoint and server files
ADD --chown=dcmcsrv:dcmcsrv files/Entrypoint.sh /entrypoint.sh
ADD --chown=dcmcsrv:dcmcsrv files/DeceasedCraft_Server_v5.5.5.zip /etc/DeceasedCraft/

# Installing required packages
RUN apk update && apk upgrade \
&&  apk add --no-cache bash vim \
&&  apk add --no-cache openjdk21

# Run the rest of the dockerfile from dcmcsrv user
# This includes when the image is run in a container
USER dcmcsrv

# Preparing server files and entrypoint
RUN cd /etc/DeceasedCraft \
&&  unzip /etc/DeceasedCraft/DeceasedCraft_Server_v5.5.5.zip \
&&  rm DeceasedCraft_Server_v5.5.5.zip \
&&  cp -r /etc/DeceasedCraft/DeceasedCraft_Server_v5.5.5/* . \
&&  java -jar forge-1.18.2-40.2.4-installer.jar --installServer \
&&  echo "eula=true" >> eula.txt \
&&  cd / \
&&  chown -R dcmcsrv:dcmcsrv /etc/DeceasedCraft/ \
&&  chmod +x /entrypoint.sh 

ADD --chown=dcmcsrv:dcmcsrv files/ops.json /etc/DeceasedCraft/DeceasedCraft_Server_v5.5.5/ops.json

ENTRYPOINT [ "./entrypoint.sh" ]
# ENTRYPOINT [ "/bin/ash" ]