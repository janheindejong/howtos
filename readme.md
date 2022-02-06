# Installing Ubuntu on an old MacBook Pro 

This is a little guide for myself how to install Ubuntu on my old 2009 MacBook Pro (5.5). I figured I'd give it a try, since the MacBook has become quite slow, and can only go to unsupported versions of macOS. Having a Linux machine might come in handy every now and then - especially for working on open-source projects or hack-the-box projects.

## Setup OS & drivers

In essence, you take the following steps: 

1. Create a partition to house Ubuntu with Mac OS X Disk Utility 
2. Create a bootable USB flash drive with an Ubuntu image with [Etcher](https://etcher.io/), or `Startup Disk Creator` that comes with Ubuntu. 
3. Start the macbook while holding Option/Alt to open the boot menu
4. RUn Ubuntu from the flash drive to see if it works 
5. Install Ubuntu from the OS running off the flash drive, with ethernet cable plugged in 
   - Select download updates 
   - Select third-party hardware stuff 
   - Minimal might not be a bad idea... 
6. Restart the Macbook, hold Option/Alt key, select EFI Boot; to make this your default one, hold the SHIFT key while clicking the little arrow below. 
7. Check if all drivers are installed properly
   - Open "Software & Updates" 
   - Click Addiontal Drivers
   - Enable any proprietary drivers

For some reason, I experienced problems with the NVIDIA 340 driver on 20.04 LTS, leading to the OS sometimes hanging (especially with FireFox). I tried a multitude of things (e.g. reverting the Kernell from 5.11 to 5.4, installing the drivers from the terminal), but nothing seemed to work. In the end, went for the 21 version of Ubuntu, and switched to Chrome. Seems to solve things for now...

## Install Google Chrome

```bash
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt remove firefox
```

## Install Docker engine

* [Install Docker Engine](https://docs.docker.com/engine/install/ubuntu/)

## Install Git 

Git credential manager is one of the two ways suggested by GitHub to cache credentials, and allow for 2FA authentication.

* Install git: `sudo apt install git` 
* Install git credential manager: https://github.com/GitCredentialManager/git-credential-manager
* Set git credential manager to use GUI: `git config --global credential.credentialStore secretservice`

## PlantUML in VSCode

* Install the PlantUML extension 
* Install Java and Graphviz: `sudo apt install default-jre graphviz`
* Configure VSCode: `"plantuml.server": "https://plantuml.com/plantuml"`

The latter just acts as a prefix for the generation of URLs.

# Howdy - facial recogniation for log-in 

You can use Howdy as the de facto Linux alternative to Windows Hello for facial recognition for logging on. See [this tutorial](https://itsfoss.com/face-unlock-ubuntu/). On my Dell XPS, the correct video device was `/dev/video2` - this is the IR camera. 

## Links

* [LifeWire tutorial](https://www.lifewire.com/dual-boot-linux-and-mac-os-4125733)
* [Terminal tutorial](https://ubuntu.com/tutorials/command-line-for-beginners)
