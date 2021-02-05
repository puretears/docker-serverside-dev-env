#!/bin/bash

if [[ ! -d /.composer ]]; then
  mkdir /.composer
fi

chmod -R ugo+rw /.composer

if [[ $# -gt 0 ]]; then
  exec gosu ${WWWUSER} "$@"
else
  /usr/bin/supervisord
fi
