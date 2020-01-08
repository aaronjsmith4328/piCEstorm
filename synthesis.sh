#!/bin/bash

# The main bulk of this is based off of Clifford Wolf's stuff found here: http://www.clifford.at/icestorm/

# This is a script to bring the pi up to speed by getting all of the syntehsis tools setup

# Make sure that swp is set to a high enough value (2048 /etc/dphys-swapfile)

# OPTIONAL (But recommended) make sure that your Pi has a fan or is running in a refrigerator because it gets a little toasty

cd ~
mkdir piCEstorm
cd piCEstorm

sudo apt -y update

sudo apt -y upgrade

# This is Cliffords stuff that we need

sudo apt -y install build-essential clang bison flex libreadline-dev \
                     gawk tcl-dev libffi-dev git mercurial graphviz   \
                     xdot pkg-config python python3 libftdi-dev \
                     qt5-default python3-dev libboost-all-dev cmake

sudo apt -y install libeigen3-dev

# Shout out to Clifford Wolf for putting all the easy instructions on his site
git clone https://github.com/cliffordwolf/icestorm.git icestorm
cd icestorm
make 
sudo make install

# Now we start by installing Yosys 

cd ../

sudo apt -y install yosys

# This is to setup the nextpnr tool

git clone https://github.com/YosysHQ/nextpnr nextpnr
cd nextpnr
cmake -DARCH=ice40 -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_GUI=OFF .
make 
sudo make install

# Now we are going to download an example git file

cd ../

#===================================================================
# *** This is the example after all of the tools are installed *** #
#===================================================================

git clone https://github.com/osresearch/up5k.git

cd up5k

make 

sudo make blink.flash


# End of example

# End of setup
