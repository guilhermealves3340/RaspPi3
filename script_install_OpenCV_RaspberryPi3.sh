#!sudo chmod 755 script_install_OpenCV_RaspberryPi3.sh
#!ls -la script.sh

#################################

# UPDATE SISTEMA
sudo apt-get update -y
sudo apt-get upgrade
sudo rpi-update

# Install dependencies
sudo apt-get install build-essential cmake pkg-config
sudo apt-get install libjpeg-dev libtiff5-dev libjasper-dev libpng12-dev
sudo apt-get install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo apt-get install libxvidcore-dev libx264-dev
sudo apt-get install libgtk2.0-dev libgtk-3-dev
sudo apt-get install libatlas-base-dev gfortran

# Setup Python 3 development tools
sudo apt-get install python3 python3-setuptools python3-dev

# Setup pip tool
wget https://bootstrap.pypa.io/get-pip.py
sudo python3 get-pip.py

# Grab OpenCV 3.4.1 and OpenCV-contrib archives
cd ~
wget -O opencv.zip https://github.com/Itseez/opencv/archive/3.4.1.zip
wget -O opencv_contrib.zip https://github.com/Itseez/opencv_contrib/archive/3.4.1.zip
unzip opencv.zip
unzip opencv_contrib.zip

# Install Numpy
sudo pip3 install numpy

# Increase swap space
  ## We are going to increase swap size from 100MB to 1024MB, to facilitate compilation of OpenCV on all four cores of Pi.
  ## Open /etc/dphys-swapfile using nano editor.  Change the value CONF_SWAPSIZE  variable to 1024.
  ## Save the edited file and activate the new swap space using the following commands to restart the service
sudo /etc/init.d/dphys-swapfile stop
sudo /etc/init.d/dphys-swapfile start

# Compile  and Install OpenCV
make -j4
sudo make install
sudo ldconfig


  ## Revert back the swap size to its original value of 100MB by editing the /etc/dphys-swapfile. And, restart the service by issuing commands.
  sudo /etc/init.d/dphys-swapfile stop
  sudo /etc/init.d/dphys-swapfile start
