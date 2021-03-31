#!/bin/bash
set -e

rm -f /bio/tmp/pids/server.pid

exec "$@"