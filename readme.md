# Package Description

This package is used to control the Unitree A1 robot with a pre-trained AI model. The training is done by this [repository](https://github.com/leggedrobotics/legged_gym). The main purpose is to provide an interface to use pre-trained AI models with unitree robots using unitree_ros package.

# Installation

## 1. Clone the repository:

```bash
git clone https://github.com/Jellal-17/unitree_model_control.git
```
## 2. Build the Docker image:

```bash
docker build -t model_control .
```

## 3. Run the docker container:
```
docker run -it \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --privileged \
    --gpus all \
    model_control 
```
- Change the name of the container (```model_control```) as you wish.
- Modify the command if you do not want to use all GPUs by replacing ```--gpus all``` with a specific GPU index (e.g., ```--gpus '"device=0"'```).
# Usage

## 1. Start the Gazebo Simulation
Run the following commands inside the Docker container:

```bash
./start_docker.sh
source devel/setup.bash
roslaunch unitree_gazebo normal.launch rname:=a1
```

## 2. Start the AI Model
Open a new terminal and access the Docker container:

```bash
./acess_docker.sh
source devel/setup.bash
rosrun unitree_model_control model_run
```

## 3. Control the Robot
Open another terminal and access the Docker container to start the ```teleop_keyboard_twist node```, which allows you to command the robot to walk:

```bash
./acess_docker.sh
rosrun teleop_twist_keyboard teleop_twist_keyboard.py
```
