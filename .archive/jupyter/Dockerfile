FROM continuumio/miniconda3:23.10.0-1
ARG DEBIAN_FRONTEND=noninteractive
ARG USER=jupyter
ARG UID=1000
ENV JUPYTER_PORT=8888

# user
RUN useradd -m -u ${UID} ${USER}

# workdir
RUN mkdir -p /app /data && \
    chown -R ${USER}:${USER} /data
WORKDIR /app

# conda
RUN conda update -c defaults -q -y conda && \
    conda install -q -y conda-libmamba-solver && \
    conda config -q --set solver libmamba

# jupyter environment
COPY environment.yml /tmp/environment.yml
RUN conda env update -n base -q -f /tmp/environment.yml

# start script
COPY start-script.sh /app/
RUN chmod +x /app/start-script.sh

USER ${USER}
ENTRYPOINT [ "./start-script.sh" ]
