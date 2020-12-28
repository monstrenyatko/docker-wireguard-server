#!/bin/bash

# Exit on error
set -e

# Load functions
source /scripts/update-app-user-uid-gid.sh

# Debug output
set -x

update_user_gid $SYS_USERNAME $SYS_GROUPNAME $SYS_GID
update_user_uid $SYS_USERNAME $SYS_UID

if [ "$1" = $APP_NAME ]; then
  shift;
  exec supervisord -c /app/supervisord.conf
fi

exec "$@"
