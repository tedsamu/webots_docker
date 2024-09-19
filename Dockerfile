# Use an official ROS 2 base image with your preferred version (Galactic or Humble)
FROM osrf/ros:humble-desktop

ARG DEBIAN_FRONTEND=noninteractive

# Install required tools and dependencies
RUN apt-get update && apt-get install -y \
    nano \
    && rm -rf /var/lib/apt/lists/*

COPY dependencies/webots_2023b_amd64.deb /tmp/dependencies/webots_2023b_amd64.deb

# Install webots
RUN apt-get update && apt-get install -y \
    ros-humble-webots-ros2 \
    && sudo dpkg -i /tmp/dependencies/webots_2023b_amd64.deb \
    ; apt-get install -f -y \
    && rm -rf /var/lib/apt/lists/*

ENV WEBOTS_HOME /usr/local/webots

# Create a non-root user with a specific UID/GID to match host user
ARG USER_ID=1000
ARG GROUP_ID=1000
RUN groupadd -g ${GROUP_ID} devgroup \
    && useradd -m -u ${USER_ID} -g devgroup devuser \
    && apt-get update && apt-get install -y sudo \
    && echo "devuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers 

# Create ros workspace
RUN mkdir -p /home/devuser/ros2_ws/src/ \
    && cd /home/devuser/ros2_ws \
    && chown -R devuser:devgroup /home/devuser/ros2_ws \
    && sudo -u devuser colcon build

# Switch to non-root user
USER devuser
ENV USER devuser
WORKDIR /home/devuser/ros2_ws


RUN echo "ros2 launch webots_ros2_universal_robot multirobot_launch.py" >> /home/devuser/.bash_history 

RUN echo "alias ros2-source=\"/home/devuser/ros2_ws/install/setup.sh\"" >> /home/devuser/.bashrc