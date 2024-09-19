# Webots ROS 2 Docker Environment

This project provides a Docker-based setup for running Webots simulations with ROS 2, specifically configured for the Humble distribution. It allows you to run Webots simulations in a containerized environment, ensuring consistency across different systems.

## Prerequisites

- Docker installed on your system
- X11 server running on your host machine (for GUI applications)

## Setup

1. Clone this repository:
   ```
   git clone git@github.com:tedsamu/webots_docker.git
   cd webots_docker
   ```

2. Download the Webots Debian package:
   - Go to the [Webots R2023b release page](https://github.com/cyberbotics/webots/releases/tag/R2023b)
   - Download the file named `webots_2023b_amd64.deb`
   - Place the downloaded file in the `dependencies/` directory of this project

3. Build the Docker image:
   ```
   ./build-docker.sh
   ```
   This script will build the Docker image and create a `ros2_ws_src` directory if it doesn't exist.

## Usage

1. To start the Docker container:
   ```
   ./enter.sh
   ```
   This will start an interactive session in the Docker container with X11 forwarding for GUI applications.

2. Once inside the container, you can run Webots simulations using ROS 2 commands. You can test that webots is working by running the following:
     ```
     ros2 launch webots_ros2_universal_robot multirobot_launch.py
     ```

3. You can develop your own ROS 2 packages by placing them in the `ros2_ws_src` directory on your host machine. This directory is mounted as a volume in the container at `/home/devuser/ros2_ws/src/`.

## Notes

- The Docker container runs with host networking and privileged mode to allow for X11 forwarding and full system access.
- The container uses a non-root user with the same UID and GID as your host user to avoid permission issues.
- Webots 2023b is installed in the container along with ROS 2 Humble.
- The `WEBOTS_HOME` environment variable is set to `/usr/local/webots` in the container.

## Troubleshooting

If you encounter any issues with X11 forwarding or permissions, ensure that:
- Your X11 server is properly configured and allowing connections
- The `DISPLAY` and `XAUTHORITY` environment variables are correctly set on your host machine

For any other issues, please check the Dockerfile and script contents, or refer to the [ROS 2 Humble documentation](https://docs.ros.org/en/humble/) and [Webots documentation](https://cyberbotics.com/doc/guide/index).