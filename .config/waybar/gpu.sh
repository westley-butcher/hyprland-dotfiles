#!/bin/sh
nvidia-smi --query-gpu=utilization.gpu,temperature.gpu --format=csv,noheader,nounits | awk -F', ' '{printf "GPU %s%% %s°C\n", $1, $2}'
