#!/bin/bash
# Entry point of boxue deloyment system

UNAMEOUT="$(uname -a)"

# Detect supported operating system
case "${UNAMEOUT}" in
  Linux*)
    MACHINE=Linux
    ;;
  Darwin*)
    MACHINE=mac
    ;;
  *)
    MACHINE="unknown"
esac

if [[ "${MACHINE}" == "unknown" ]]; then
  echo "Unsupported operating system. Fly only supports macOS and Linux." >&2
  exit 1
fi

# Define the must-have environment variables...
# If this script was executed before, these following variables
# should have been defined. But if it is the first time execution,
# we have to set default values for them to ensure the whole
# system could work properly.
export APP_PORT=${APP_PORT:-8080}
export APP_SERVICE=${APP_SERVICE:-"bx.app"}
export DB_PORT=${DB_PORT:-33060}
export WWWUSER=${WWWUSER:-$UID}
export WWWGROUP=${WWWGROUP:-$(id -g)}

# Ensure the docker service is working
# 2>&1: We don't care about the details if docker haven't been
# started yet. The $? is enough.
if ! docker info > /dev/null 2>&1; then
  echo "Docker is not running. You should start docker before running this script." >&2
  exit 1
fi

# Determine if fly is currently up
# We only forward PHP commands to Fly when Fly is running.
PSRESULT="$(docker-compose ps -q)"

if docker-compose ps | grep 'Exit'; then
  echo "Shutting down old Fly containers..." >&2

  docker-compose down > /dev/null 2>&1

  EXEC="no"
elif [[ -n "${PSRESULT}" ]]; then
  EXEC="yes"
else
  EXEC="no"
fi

function fly_is_not_running {
  echo "Fly is not running." >&2
  echo "" >&2
  echo "You may Fly using the following command: './fly.sh up' or './fly.sh up -d'" >&2

  exit 1
}

if [[ $# -gt 0 ]]; then
  echo $@
  if [[ -f ./.env ]]; then
    # Source the .env file to make Laravel environments take effect.
    source ./.env
  fi

  # Proxy PHP commands
  if [[ "$1" == "php" ]]; then
    shift 1

    if [[ ${EXEC} == "yes" ]]; then
      docker-compose exec -u fly "${APP_SERVICE}" php "$@"
    else
      fly_is_not_running
    fi

  # Proxy Composer commands
  elif [[ "$1" == "composer" ]]; then
    shift 1

    if [[ ${EXEC} == "yes" ]]; then
      docker-compose exec -u fly "${APP_SERVICE}" composer "$@"
    else
      fly_is_not_running
    fi

  # Proxy Artisan commands
  elif [[ "$1" == "artisan" ]]; then
    shift 1

    if [[ ${EXEC} == "yes" ]]; then
      docker-compose exec -u fly "${APP_SERVICE}" php artisan "$@"
    else
      fly_is_not_running
    fi

  # Proxy Laravel Tinker session
  elif [[ "$1" == "tinker" ]]; then
    shift 1

    if [[ ${EXEC} == "yes" ]]; then
      docker-compose exec -u fly "${APP_SERVICE}" php artisan tinker
    else
      fly_is_not_running
    fi

  # Proxy Node commands
  elif [[ "$1" == "node" ]]; then
    shift 1

    if [[ ${EXEC} == "yes" ]]; then
      docker-compose exec -u fly "${APP_SERVICE}" node "$@"
    else
      fly_is_not_running
    fi

  # Proxy NPM commands
  elif [[ "$1" == "npm" ]]; then
    shift 1

    if [[ ${EXEC} == "yes" ]]; then
      docker-compose exec -u fly "${APP_SERVICE}" npm "$@"
    else
      fly_is_not_running
    fi

  # Proxy NPX commands
  elif [[ "$1" == "npx" ]]; then
    shift 1

    if [[ ${EXEC} == "yes" ]]; then
      docker-compose exec -u fly "${APP_SERVICE}" npx "$@"
    else
      fly_is_not_running
    fi

  # Proxy Yarn commands
  elif [[ "$1" == "yarn" ]]; then
    shift 1

    if [[ ${EXEC} == "yes" ]]; then
      docker-compose exec -u fly "${APP_SERVICE}" yarn "$@"
    else
      fly_is_not_running
    fi

  # Proxy MySQL sesstion
  elif [[ "$1" == "mysql" ]]; then
    if [[ ${EXEC} == "yes" ]]; then
      docker-compose exec \
        mysql \
        # The following MYSQL_* variables are defined in docker-compose.yml
        bash -c 'MYSQL_PWD=${MYSQL_PASSWORD} mysql -u ${MYSQL_USER} ${MYSQL_DATABASE}'
    else
      fly_is_not_running
    fi

  # Proxy bash or shell commands
  elif [[ "$1" == "shell" ]] || [[ "$1" == "bash" ]]; then
    if [[ ${EXEC} == "yes" ]]; then
      docker-compose exec -u fly "${APP_SERVICE}" bash
    else
      fly_is_not_running
    fi

  else
    # Such as ./fly.sh up
    docker-compose "$@"
  fi
else
  docker-compose ps
fi
