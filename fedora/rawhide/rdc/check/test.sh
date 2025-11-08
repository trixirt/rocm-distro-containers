#!/bin/sh

set -x

rdcd --address 127.0.0.1 -u &

sleep 5

rdci discovery 127.0.0.1 -l -u





