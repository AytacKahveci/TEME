# TEME
TEME Workspace Installation

In order to build TEME workspace, run the "install_script.sh".
It will create a teme folder and the following workspaces inside it:  
  - ros_control_ws
  - dynamixel_workbench
  - kuka_ws
  - image_processing_ws
  - ros_gui_ws (If build_gui arg is given to the script. ./install_script.sh build_gui)

Workspaces should be sourced after build process. E.g:
  `echo 'source ~TEME/teme/ros_control_ws/devel/setup.bash' >> ~/.bashrc`
