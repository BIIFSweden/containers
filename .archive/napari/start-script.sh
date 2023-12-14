#!/usr/bin/env bash
xpra start --daemon=no --bind-tcp=0.0.0.0:${NAPARI_PORT} --html=on --start-child=/app/start-child.sh --exit-with-children=yes --exit-with-client=yes
