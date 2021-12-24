# Installing Ubuntu on an old MacBook Pro 

This is a little guide for myself how to install Ubuntu on my old 2009 MacBook Pro (5.5). I figured I'd give it a try, since the MacBook has become quite slow, and can only go to unsupported versions of macOS. Having a Linux machine might come in handy every now and then - especially for working on open-source projects or hack-the-box projects.

## Overview

In essence, you take the following steps: 

1. Create a partition to house Ubuntu with Mac OS X Disk Utility 
2. Create a bootable USB flash drive with an Ubuntu image with [Etcher](https://etcher.io/)
3. Start the macbook while holding Option to open the boot menu
4. Try running Ubuntu from the flash drive to see if it works 
5. Install Ubuntu from the OS running off the flash drive (preferably with ethernet connection) 
6. Restart the Macbook, hold Option key, select EFI Boot
6. Get the Wifi drivers working (requires ethernet connection)
   - Open "Software & Updates" 
   - Click Addiontal Drivers
   - Enable the Broadcom blabla


For some reason, the Nvidia 340 driver won't install properly, and FireFox is also not working properly. Install Google Chrome instead: 

1. sudo apt update
2. wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
3. sudo dpkg -i google-chrome-stable_current_amd64.deb

Remove Firefox: 

* sudo apt remove firefox

## Links

* [LifeWire tutorial](https://www.lifewire.com/dual-boot-linux-and-mac-os-4125733)
