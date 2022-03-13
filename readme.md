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

After installing the PlantUML extension in VSCode, there are two ways to setup it up: with local rendering, or server-side rendering. 

* Serverside rendering -> add the following to the VSCode settings: `"plantuml.server": "https://plantuml.com/plantuml", "plantuml.render": "PlantUMLServer"`
* Local rendering -> install Java and Graphvix: `sudo apt install default-jre graphviz`

# Howdy - facial recogniation for log-in 

You can use Howdy as the de facto Linux alternative to Windows Hello for facial recognition for logging on. See [this tutorial](https://itsfoss.com/face-unlock-ubuntu/). On my Dell XPS, the correct video device was `/dev/video2` - this is the IR camera. 

## Fixing bluetooth connection issues 

I had some issues with connecting bluetooth devices; the trick was to re-install `bluez`. 

On second thought, this did not fix it... 

I did got a bit further in debugging a mouse lag issue, where the mouse would freeze for half a second after several seconds of inactivity. This is some powersaving feature, and it can be addressed as followes: 

```bash
sudo apt install powertop
powertop -> go to tunables, toggle unknown USB device to "BAD" 
``` 

This article seems to cover it quite well: https://hamwaves.com/usb.autosuspend/en/

Ok... I've learned some more. Apparantly, all "bus" type devices have autosuspend enable by default, and all other devices not. Since I don't have a specific driver for my Logitech Master MX3, it is listed as a typical bluetooth device, and apparently the bluetooth receiver from Foxconn has some standard functionality for bluetooth mice. There is an unofficial driver for logitech, see [here](https://danishshakeel.me/configure-logitech-mx-master-3-on-linux-logiops/)

Finally got it. I need to add add a udev role that either sets the power/control attribute to on, or the power/autosuspend attribute to -1: 

```
# Disable autosuspend for bluetooth mouse 
ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="0489", ATTR{idProduct}=="e0a2", ATTR{power/control}="on"

ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="0489", ATTR{idProduct}=="e0a2", ATTR{power/autosuspend}="-1"
```


## Fixing bluetooth headphone issues 

This is a really annoying one. I've tried: 

- Reading on PulseAudio: https://wiki.debian.org/BluetoothUser/a2dp 
- Managing bluetooth devices with bluetoothctl: https://www.makeuseof.com/manage-bluetooth-linux-with-bluetoothctl/
- Changing latency of pulseaudio: https://askubuntu.com/questions/475987/a2dp-on-pulseaudio-terrible-choppy-skipping-audio
- Disabling tsched: https://askubuntu.com/questions/371595/for-pulseaudio-what-does-tsched-do-and-what-are-the-defaults


## Setting Keychron Fn functions to default

Had some difficulty setting up my Keychron keyboard to use the Fn keys by default, not the multimedia keys. Found the solution [here](https://mikeshade.com/posts/keychron-linux-function-keys/):

- Set to keyboard to windows mode 
- Switch Function mode by holding Fn+X+L
- Switch modes: `echo 0 | sudo tee /sys/module/hid_apple/parameters/fnmode`
- Make persisten by running `echo "options hid_apple fnmode=0" | sudo tee -a /etc/modprobe.d/hid_apple.conf`
- If necessary, run sudo update-initramfs -u


## Links

* [LifeWire tutorial](https://www.lifewire.com/dual-boot-linux-and-mac-os-4125733)
* [Terminal tutorial](https://ubuntu.com/tutorials/command-line-for-beginners)
