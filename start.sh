#!/usr/bin/env bash
set -e
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

FACTORIO_DIR="${SCRIPT_DIR}/factorio"
SAVES_DIR="${SCRIPT_DIR}/saves"
CONFIG_DIR="${SCRIPT_DIR}/config"
SERVER_MANAGER_DIR="${SCRIPT_DIR}/server-manager"


if [ ! -d ${FACTORIO_DIR} ]; then
    >&2 echo "Factorio directory '${FACTORIO_DIR}' does not exist, --init or --update."
    exit 1
elif [ ! -d ${SERVER_MANAGER_DIR} ]; then
    >&2 echo "Server manager directory'${SERVER_MANAGER_DIR}' does not exist, use --init."
    exit 1
elif [ ! -d ${CONFIG_DIR} ]; then
    >&2 echo "Configuration directory '${CONFIG_DIR}' does not exist!"
    exit 1
elif [ ! -d ${SAVES_DIR} ]; then
    >&2 echo "Saves directory '${SAVE_DIR}' does not exist!"
    exit 1
fi


FACTORIO_MAP_CONFIG="${CONFIG_DIR}/map_gen_settings.json"
FACTORIO_SERVER_CONFIG="${CONFIG_DIR}/server_settings.json"
FACTORIO_SERVER_MANAGER_CONFIG="${CONFIG_DIR}/server_manager_settings.json"

FACTORIO_SERVER_BIN='bin/x64/factorio'
FACTORIO_SERVER_MANAGER_BIN="${SERVER_MANAGER_DIR}/factorio-server-manager"

HOST='0.0.0.0'
PORT='8080'
MAX_UPLOAD='20971520'

SERVER_MANAGER_OPTS="-dir ${FACTORIO_DIR} -bin ${FACTORIO_SERVER_BIN} -host ${HOST} -port ${PORT} -max-upload ${MAX_UPLOAD} -conf ${FACTORIO_SERVER_MANAGER_CONFIG} -config ${FACTORIO_SERVER_CONFIG}"


cd ${SAVES_DIR}
NEW_MAP='map_00'
echo ${FACTORIO_MAP_CONFIG}
"${FACTORIO_DIR}/${FACTORIO_SERVER_BIN}" --map-gen-settings "${FACTORIO_MAP_CONFIG}" --create "${NEW_MAP}"

cd ${SERVER_MANAGER_DIR}
${FACTORIO_SERVER_MANAGER_BIN} ${SERVER_MANAGER_OPTS}
echo "Server manager closed!"

exit 0
