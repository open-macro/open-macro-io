#!/bin/bash
# Configure Ubuntu 14.04 EC2 instance to run macro models in Octave + Dynare

cd "$(dirname "$0")"

# update package lists
sudo apt-get update

# install Octave
sudo apt-get install -y octave

# install Dynare
sudo apt-get install -y dynare

# install emacs24
sudo apt-get install -y emacs24

# fiddle with bash settings (superficial stuff)
cp config/.bashrc /home/ubuntu/ 

# fiddle with emacs settings (make m-files open in Octave mode by default)
cp config/init.el /home/ubuntu/.emacs.d/
