#!/bin/bash

if [[ ! -d /.composer ]]; then
  mkdir /.composer
fi

chmod -R ugo+rw /.composer

if [[ $# -gt 0 ]]; then
  exec gosu ${WWWUSER} "$@"
else
  /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
fi
