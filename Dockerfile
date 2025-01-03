# MIT License
#
# Copyright (c) 2024 Sathvik Kadimisetty
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
# Contact: satvik.kadimisetty@gmail.com

# Use the official ROS Noetic desktop full image as base
FROM osrf/ros:noetic-desktop-full

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV Torch_DIR=/opt/libtorch

# Install necessary tools and ROS dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    wget \
    unzip \
    git \
    python3-pip \
    python3-catkin-tools \
    python3-rosdep \
    python3-rosinstall \
    python3-rosinstall-generator \
    python3-wstool \
    libyaml-cpp-dev \
    libeigen3-dev \
    liblcm-dev \
    libglm-dev \
    libgazebo11-dev \
    ros-noetic-teleop-twist-keyboard \
    ros-noetic-ros-controllers \
    ros-noetic-controller-manager \
    ros-noetic-controller-interface \
    ros-noetic-joint-state-controller \
    ros-noetic-effort-controllers \
    ros-noetic-joint-trajectory-controller \
    ros-noetic-robot-state-publisher \
    ros-noetic-xacro \
    ros-noetic-gazebo-ros-pkgs \
    ros-noetic-gazebo-ros-control && \
    rm -rf /var/lib/apt/lists/*


    # Initialize rosdep
RUN if [ ! -f /etc/ros/rosdep/sources.list.d/20-default.list ]; then \
        rosdep init; \
    fi && rosdep update


# Install Libtorch
WORKDIR /opt
RUN wget https://download.pytorch.org/libtorch/cpu/libtorch-cxx11-abi-shared-with-deps-2.0.1%2Bcpu.zip && \
    unzip libtorch-cxx11-abi-shared-with-deps-2.0.1+cpu.zip && \
    rm libtorch-cxx11-abi-shared-with-deps-2.0.1+cpu.zip

# Clone Unitree ROS repository
WORKDIR /root/unitree_ros/src
RUN git clone https://github.com/mertgungor/unitree_ros.git . --recurse-submodules

# Clone Unitree Model Control package
RUN git clone https://github.com/mertgungor/unitree_model_control.git

# Build the workspace
WORKDIR /root/unitree_ros
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash && catkin_make"

# Set up environment for the container
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
RUN echo "source /root/unitree_ros/devel/setup.bash" >> ~/.bashrc

# Default command
CMD ["/bin/bash"]
