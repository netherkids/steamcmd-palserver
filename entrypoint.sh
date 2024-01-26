#!/bin/sh

ulimit -n "${ULIMIT}"
cd ${STEAMCMDDIR}
chown "${USER}":"${GROUP}" -R /opt/

if [ -e "/home/steam/.steam/sdk32/steamclient.so" ]
then
  echo "steamclient.so found."
else
  echo "steamclient.so not found."
  su steam -c "ln -s ${STEAMCMDDIR}/linux32/steamclient.so ~/.steam/sdk32/steamclient.so"
  if [ -e "/home/steam/.steam/sdk32/steamclient.so" ]
  then
    echo "steamclient.so link created."
  fi
fi

# update
${STEAMCMDDIR}/steamcmd.sh +@sSteamCmdForcePlatformType linux +login anonymous \
+force_install_dir "${SERVERDIR}/palserver/" +app_update 2394010  \
+quit

# server start
su "${USER}" -c "cd ${SERVERDIR}/palserver/ && ./PalServer.sh"
