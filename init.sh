#!/usr/bin/env bash
set -e
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

SERVER_MANAGER_FOLDER="${SCRIPT_DIR}/server-manager"
SERVER_MANAGER_VERSION='0.4.2'
SERVER_MANAGER_FILE_NAME='factorio-server-manager-linux-x64'
SERVER_MANAGER_FILE_NAME_ZIP="${SERVER_MANAGER_FILE_NAME}.zip"
SERVER_MANAGER_URL="https://github.com/MajorMJR/factorio-server-manager/releases/download/${SERVER_MANAGER_VERSION}/${SERVER_MANAGER_FILE_NAME_ZIP}"

TMP_FOLDER="/tmp/${SERVER_MANAGER_FILE_NAME}"
TMP_ZIP="/tmp/${SERVER_MANAGER_FILE_NAME_ZIP}"
safe-rm -f ${TMP_ZIP} 
safe-rm -Rf ${TMP_FOLDER}
wget --no-check-certificate "${SERVER_MANAGER_URL}" -O "${TMP_ZIP}"
unzip -qo "${TMP_ZIP}" -d '/tmp'

safe-rm -Rf ${SERVER_MANAGER_FOLDER}
mv ${TMP_FOLDER} ${SERVER_MANAGER_FOLDER}
safe-rm -f "${SERVER_MANAGER_FOLDER}/conf.json"

sh "${SCRIPT_DIR}/update.sh"
