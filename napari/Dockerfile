FROM continuumio/miniconda3:23.10.0-1
ARG DEBIAN_FRONTEND=noninteractive
ARG USER=napari
ARG UID=1000
ENV NAPARI_PORT=9876

# user
RUN useradd -m -u ${UID} ${USER}

# workdir
RUN mkdir -p /app /data && \
    chown -R ${USER}:${USER} /data
WORKDIR /app

# napari dependencies
RUN apt update && \
    apt install -y mesa-utils libgl1-mesa-glx libglib2.0-0 libfontconfig1 libxrender1 libdbus-1-3 libxkbcommon-x11-0 libxi6 libxcb-icccm4 libxcb-image0 libxcb-keysyms1 libxcb-randr0 libxcb-render-util0 libxcb-xinerama0 libxcb-xinput0 libxcb-xfixes0 libxcb-shape0

# xpra
RUN apt update && \
    apt install -y ca-certificates wget && \
    wget -O "/usr/share/keyrings/xpra.asc" https://xpra.org/xpra.asc && \
    wget -O "/etc/apt/sources.list.d/xpra.sources" https://xpra.org/repos/bullseye/xpra.sources && \
    apt update && \
    apt install -y xpra
ENV XDG_RUNTIME_DIR=/tmp/xdg

# conda
RUN conda update -c defaults -q -y conda && \
    conda install -q -y conda-libmamba-solver && \
    conda config -q --set solver libmamba

# napari environment
COPY environment.yml /tmp/environment.yml
RUN conda env update -n base -q -f /tmp/environment.yml

# start script
COPY start-script.sh start-child.sh /app/
RUN chmod +x /app/start-script.sh /app/start-child.sh

USER ${USER}
ENTRYPOINT [ "./start-script.sh" ]
