FROM cavenel/tissuumaps:3.2
ARG DEBIAN_FRONTEND=noninteractive
ARG USER=tissuumaps
ARG UID=1000
ENV TISSUUMAPS_PORT=80

# user
RUN adduser -u ${UID} -D ${USER}

# workdir
RUN mkdir -p /app /data && \
    chown -R ${USER}:${USER} /data
WORKDIR /app

# start script
COPY start-script.sh /app/
RUN chmod +x /app/start-script.sh

USER ${USER}
ENTRYPOINT [ "./start-script.sh" ]
