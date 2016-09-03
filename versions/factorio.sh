#!/usr/bin/env bash
ARGS=$(echo "$@" | sed 's/--latency-ms [0-9]\+//')
/opt/factorio/factorio/bin/x64/factorio.bin ${ARGS}
