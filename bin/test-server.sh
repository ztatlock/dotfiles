#!/usr/bin/env bash

port="8000"
echo "http://127.0.0.1:$port"
python3 -m http.server "$port"
