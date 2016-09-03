#!/usr/bin/env bash
set -e
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if  [ $# -eq 0 ]; then
    VERSION='0.14.3'
elif [ $# -eq 1 ]; then
    VERSION="$1"
else
    >&2 echo 'Error: too many input arguments!'
    >&1 echo "Usage: ./update.sh [VERSION]"
    exit 1
fi
echo "Updating to factorio version ${VERSION}..."

VERSION_DIR="${SCRIPT_DIR}/versions"
DL_URL="https://www.factorio.com/get-download/${VERSION}/headless/linux64"

SERVER_TGZ_FILENAME="factorio_headless_${VERSION}.tar.gz"
SERVER_TGZ_FILE="${VERSION_DIR}/${SERVER_TGZ_FILENAME}"
if [ ! -f ${SERVER_TGZ_FILE} ]; then
    wget --no-check-certificate ${DL_URL} -O ${SERVER_TGZ_FILE}
fi


FACTORIO_DIR="${SCRIPT_DIR}/factorio"
CONFIG_DIR="${SCRIPT_DIR}/config"
SAVES_DIR="${SCRIPT_DIR}/saves"

CURRENT_GAME_DIR="${FACTORIO_DIR}"
CURRENT_GAME_SAVE_DIR="${CURRENT_GAME_DIR}/saves"
CURRENT_GAME_BIN_DIR="${CURRENT_GAME_DIR}/bin/x64"
CURRENT_GAME_BIN="${CURRENT_GAME_BIN_DIR}/factorio"

mkdir -p ${CURRENT_GAME_DIR}
safe-rm -Rf "${CURRENT_GAME_DIR}/*"
tar -xzf ${SERVER_TGZ_FILE} --directory ${CURRENT_GAME_DIR} --strip-components=1

mv "${CURRENT_GAME_BIN}" "${CURRENT_GAME_BIN}.bin"
cp "${VERSION_DIR}/factorio.sh" "${CURRENT_GAME_BIN_DIR}"
ln -s "${CURRENT_GAME_BIN}.sh" "${CURRENT_GAME_BIN}"

mkdir -p ${SAVES_DIR}
safe-rm -Rf "${CURRENT_GAME_SAVE_DIR}"
ln -s "${SAVES_DIR}" ${CURRENT_GAME_SAVE_DIR}

cd ${SAVES_DIR}
/opt/factorio/factorio/bin/x64/factorio -h

echo "${VERSION}" > "${VERSION_DIR}/current_version.txt"
echo "Successfully installed headless factorio server version ${VERSION}!" 

