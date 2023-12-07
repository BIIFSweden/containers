#!/usr/bin/env bash
python -Xfrozen_modules=off -m jupyter lab --notebook-dir=/data --ip=0.0.0.0 --port=${JUPYTER_PORT} --no-browser
