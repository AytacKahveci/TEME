#!/bin/bash
cwd=$(pwd)
build_gui=False

for ARGS in "$@"
do
	if [ ${ARGS} == 'build_gui' ]; then
  		echo "all workspaces will be build"
        build_gui=True
	fi
done

echo $cwd


## create main folder
mkdir teme
cd ${cwd}/teme

####### ros_control_ws #########
echo "ros_control_ws is building"
mkdir -p ros_control_ws/src
cd ros_control_ws/src
git clone -b teme-devel https://github.com/AytacKahveci/ros_control.git
git clone -b https://github.com/AytacKahveci/ros_controllers.git
git clone -b https://github.com/AytacKahveci/control_toolbox.git

cd ..
catkin_make -DCMAKE_BUILD_TYPE=Release
###### end ros_control_ws #######

####### dynamixel_workbench #########
echo "dynamixel_workbench is building....."
cd ${cwd}/teme
mkdir -p dynamixel_workbench/src
cd dynamixel_workbench/src
git clone -b teme-devel https://github.com/AytacKahveci/dynamixel-workbench.git
cd ..
catkin_make -DCMAKE_BUILD_TYPE=Release
####### end dynamixel_workbench #########

####### kuka_ws #########
echo "kuka_ws is building....."
cd ${cwd}/teme
mkdir -p kuka_ws/src
cd kuka_ws/src
git clone -b teme-devel https://github.com/AytacKahveci/KukaRosOpenCommunication.git
echo "Deleting moveit depended packages"
rm -rf src/KukaRosOpenCommunication/kuka_moveit_configuration
rm -rf src/kuka_exp/kuka_moveit_config

cd ..
catkin_make -DCMAKE_BUILD_TYPE=Release
####### end_kuka_ws #########


###### image_processing_ws #####
echo "image_processing_ws is building"
cd ${cwd}/teme
mkdir -p image_processing_ws/src
cd image_processing_ws/src
git clone -b teme-devel https://github.com/AytacKahveci/image_processing.git
cd ${cwd}/teme/image_processing_ws
catkin_make --pkg teme_msgs
catkin_make --pkg object_position_msgs
catkin_make -DCMAKE_BUILD_TYPE=Release
####### end_image_processing_ws #########

if [ ${build_gui} == True ]; then
    ###### ros_gui_ws #####
    echo "ros_gui_ws is building"
    cd ${cwd}/teme
    mkdir -p ros_gui_ws/src
    cd ros_gui_ws/src
    git clone -b teme-devel https://github.com/AytacKahveci/ros_gui.git
    cd ..
    catkin_make -DCMAKE_BUILD_TYPE=Release
    ###### end ros_gui_ws #####
fi
