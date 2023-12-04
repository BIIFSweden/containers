FROM continuumio/miniconda3:23.10.0-1
ARG DEBIAN_FRONTEND=noninteractive

RUN mkdir -p /data
WORKDIR /data

# conda
RUN conda update -c defaults -q -y conda && \
    conda install -q -y conda-libmamba-solver && \
    conda config -q --set solver libmamba

# jupyter environment
COPY environment.yml /tmp/environment.yml
RUN conda env update -n base -q -f /tmp/environment.yml

EXPOSE 8888
CMD ["python", "-Xfrozen_modules=off", "-m", "jupyter", "lab", "--notebook-dir=/opt/notebooks", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
