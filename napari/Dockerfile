FROM continuumio/miniconda3:23.10.0-1

RUN mkdir -p /data
WORKDIR /data

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

# conda
RUN conda update -c defaults -q -y conda && \
    conda install -q -y conda-libmamba-solver && \
    conda config -q --set solver libmamba

# napari environment
COPY environment.yml /tmp/environment.yml
RUN conda env update -n base -q -f /tmp/environment.yml

# napari startup script
COPY start-child.sh /opt/start-child.sh
RUN chmod +x /opt/start-child.sh

EXPOSE 9876
ENV XDG_RUNTIME_DIR=/tmp/xdg
CMD ["xpra", "start", "--daemon=no", "--bind-tcp=0.0.0.0:9876", "--html=on", "--start-child=/opt/start-child.sh", "--exit-with-children=yes", "--exit-with-client=yes"]
