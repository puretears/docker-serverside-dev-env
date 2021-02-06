#!/bin/bash

if [[ $# -gt 0 ]]; then
  exec gosu ${WWWUSER} "$@"
else
  /usr/bin/supervisord
fi
