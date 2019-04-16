#!/bin/sh
set -e

if [ "$1" = 'nginx' ]; then
    exec nginx "-g daemon off;"
else
    exec "$@"
fi
