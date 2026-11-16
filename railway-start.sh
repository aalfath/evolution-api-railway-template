#!/bin/bash
# Railway start script for Evolution API.
# Sets sensible defaults for every setting the template doesn't expose as a
# variable. Any variable you add on the Railway service wins over these.
set -e

# d NAME VALUE: export NAME=VALUE unless NAME is already set (even to "").
d() { eval "[ -n \"\${$1+x}\" ]" || export "$1=$2"; }

# Railway routes the public domain and the health check to $PORT.
export SERVER_PORT="${PORT:-${SERVER_PORT:-8080}}"

d SERVER_TYPE http
d DATABASE_PROVIDER postgresql
d DATABASE_CONNECTION_CLIENT_NAME evolution_exchange
d DATABASE_SAVE_DATA_INSTANCE true
d DATABASE_SAVE_DATA_NEW_MESSAGE true
d DATABASE_SAVE_MESSAGE_UPDATE true
d DATABASE_SAVE_DATA_CONTACTS true
d DATABASE_SAVE_DATA_CHATS true
d DATABASE_SAVE_DATA_LABELS true
d DATABASE_SAVE_DATA_HISTORIC true
d CACHE_REDIS_ENABLED true
d CACHE_REDIS_PREFIX_KEY evolution
d CACHE_REDIS_SAVE_INSTANCES false
d CACHE_LOCAL_ENABLED false
d AUTHENTICATION_EXPOSE_IN_FETCH_INSTANCES true
d DEL_INSTANCE false
d TELEMETRY_ENABLED false
d LANGUAGE en
d LOG_LEVEL ERROR,WARN,INFO,LOG
d LOG_BAILEYS error
d LOG_COLOR false
d QRCODE_LIMIT 30
d CONFIG_SESSION_PHONE_CLIENT "Evolution API"
d CONFIG_SESSION_PHONE_NAME Chrome

# The image bakes a public demo API key into /evolution/.env. Refuse to start
# without our own key, so the demo key can never protect a real server.
if [ -z "${AUTHENTICATION_API_KEY}" ] || [ "${#AUTHENTICATION_API_KEY}" -lt 16 ]; then
  echo "AUTHENTICATION_API_KEY must be set to at least 16 characters." >&2
  exit 1
fi
if [ -z "${DATABASE_CONNECTION_URI}" ]; then
  echo "DATABASE_CONNECTION_URI is not set (expected \${{Postgres.DATABASE_URL}})." >&2
  exit 1
fi

# Runs the Prisma migrations for $DATABASE_PROVIDER, then starts the API.
. ./Docker/scripts/deploy_database.sh
exec npm run start:prod
