#!/bin/sh

cd app
swipl ./start.pl "$@" || echo "run error code: $?"