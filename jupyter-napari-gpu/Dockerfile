FROM nvidia/cuda:12.1.1-runtime-ubuntu22.04
ARG DEBIAN_FRONTEND=noninteractive
ARG USER=jupyter
ARG UID=1000

# set environment variables
ENV XDG_RUNTIME_DIR=/run/user/${UID}
ENV DISPLAY=:0

# create unprivileged user
RUN useradd -m -u ${UID} ${USER} && \
    mkdir -p ${XDG_RUNTIME_DIR} && \
    chmod -R 700 ${XDG_RUNTIME_DIR} && \
    chown -R ${USER}:${USER} ${XDG_RUNTIME_DIR}

# install system dependencies
RUN apt-get update && \
    apt-get install -y wget git ca-certificates

# install xpra distribution
RUN wget -O /usr/share/keyrings/xpra.asc https://xpra.org/xpra.asc && \
    wget -O /etc/apt/sources.list.d/xpra.sources https://xpra.org/repos/jammy/xpra.sources && \
    apt-get update && \
    apt-get install -y xpra

# install napari dependencies
RUN apt-get install -y mesa-utils libgl1-mesa-glx libglib2.0-0 libfontconfig1 libxrender1 libdbus-1-3 libxkbcommon-x11-0 libxi6 libxcb-icccm4 libxcb-image0 libxcb-keysyms1 libxcb-randr0 libxcb-render-util0 libxcb-xinerama0 libxcb-xinput0 libxcb-xfixes0 libxcb-shape0

# install start script
RUN mkdir -p /app
COPY start-script.sh /app/
RUN chmod +x /app/start-script.sh

# create data directory
RUN mkdir -p /data && \
    chown -R ${USER}:${USER} /data

# switch to unprivileged user
USER ${USER}
WORKDIR /home/${USER}

# install and configure miniconda
RUN wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    bash Miniconda3-latest-Linux-x86_64.sh -b && \
    rm Miniconda3-latest-Linux-x86_64.sh
ENV PATH="/home/${USER}/miniconda3/bin:${PATH}"
RUN conda init && \
    conda update -y conda && \
    conda install -y conda-libmamba-solver && \
    conda config --set solver libmamba

# update base environment
COPY environment.yml .
RUN conda env update -n base -f environment.yml && \
    rm environment.yml

WORKDIR /app
ENTRYPOINT [ "./start-script.sh" ]
