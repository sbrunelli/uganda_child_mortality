#!/bin/sh

python src/main.py | tee log/run.log
mv log/run.log log/run_$(date +"%Y%m%d_%H%M").log

exit 0
