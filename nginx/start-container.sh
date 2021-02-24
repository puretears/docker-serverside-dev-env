#!/bin/bash

if [[ $# -gt 0 ]]; then
  exec gosu ${WWWUSER} "$@"
else
  /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
fi
