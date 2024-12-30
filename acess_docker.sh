#!/bin/bash

# Allow display access
xhost +local:root

# Open a new shell in the running container
docker exec -it model_control /bin/bash