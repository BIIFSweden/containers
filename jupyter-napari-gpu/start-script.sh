#!/usr/bin/env bash
conda run -n jupyter-napari-gpu --no-capture-output jupyter lab --notebook-dir=/home/jupyter/data --ip=0.0.0.0 --port=8888 --no-browser --PasswordIdentityProvider.token=''
