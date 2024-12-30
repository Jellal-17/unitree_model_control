#!/bin/bash

# Initial command to run the docker
#docker run -it \
    # --env="DISPLAY" \
    # --env="QT_X11_NO_MITSHM=1" \
    # --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    # --privileged \
    # --gpus all \
    # model_control  // change the name of the container as you wish

# Start the Docker container and attach to it
docker start -ai model_control