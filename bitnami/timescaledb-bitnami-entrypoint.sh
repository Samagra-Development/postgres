#!/usr/bin/env bash

# We have to use the bitnami configuration variable to add timescaledb to
# shared preload list, or else it gets overwritten.
if [ -z "$POSTGRESQL_SHARED_PRELOAD_LIBRARIES" ]
then
    POSTGRESQL_SHARED_PRELOAD_LIBRARIES="citus,timescaledb,pg_cron"
else
    POSTGRESQL_SHARED_PRELOAD_LIBRARIES="citus,timescaledb,pg_cron,$POSTGRESQL_SHARED_PRELOAD_LIBRARIES"
fi
export POSTGRESQL_SHARED_PRELOAD_LIBRARIES

# Fall through to the original entrypoint. Note that we use exec here because
# this wrapper script shouldn't change PID 1 of the container.
exec /opt/bitnami/scripts/postgresql/entrypoint.sh "$@"
