# Setting up VirtualBox

## Install

Installing virtualbox can be done through default repository: `sudo apt get virtualbox`.

## Getting networking to work 

For some reason, CentOS 7.9 doesn't automatically connect the network adapter. To do so, run `dhclient`, to contact the DHCP server, and set the network configuration. To make sure it connects on startup, run: 

`nmcli con mod <DEVICENAME HERE> connection.autoconnect yes`

## Setting up Virtual Box Guest Additions 

Guest additions is a set of tools that you can install in the guest VM, that facilitate things like file-sharing, clipboard sharing, and more. 

To install it, download the iso from Oracle, mount it to the VM through the VirtualBox UI. Installation might fail initially, because it requires building things for the guest kernel. To do this, yum install the following: 

perl, gcc, kernel-devel 

If it still doesn't work, check if kernel-devel is the same version as your running kernel: 

- uname -r 
- ls /usr/src/kernels 

If not, install the correct one: 

- yum install "kernel-devel-uname-r == $(uname -r)"

