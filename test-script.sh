#!/bin/bash
set -e
source /opt/ros/galactic/setup.bash
cd /ros2_ws
source install/setup.bash && colcon test --packages-select tortoisebot_waypoints --event-handler=console_direct+ 
colcon test-result --all
