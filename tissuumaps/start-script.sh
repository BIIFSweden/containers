#!/usr/bin/env sh
gunicorn --bind=0.0.0.0:${TISSUUMAPS_PORT} tissuumaps:app
