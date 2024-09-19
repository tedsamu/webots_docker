# Build docker image
docker build --build-arg USER_ID=$(id -u) --build-arg GROUP_ID=$(id -g) -t webots .

# Create, if needed, a shared folder used for your own developed ROS2 packages.
# This folder will be mounted as a volume when the container is started at ~/ros2_ws/src/
mkdir -p ros2_ws_src