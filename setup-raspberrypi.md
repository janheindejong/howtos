# Setup Raspberry Pi 

## Fresh install 

First, create a flash SSD using [raspberrypi.com/software](https://raspberrypi.com/software). I used Raspberry Pi OS Lite, since no desktop is needed, and this has the best integration with the hardware. I've used the following config: 

* *hostname*: `raspberrypi`
* *username*: `janhein`
* *password*: beats me? 

Transfer the SSD to the Pi and power it up. Find the Pi on your network (ask Claudia how to do this). Once found, you can ssh to it, like so: 

```zsh 
ssh janhein@<ip-address>
```

To make life easy, update your `/etc/hosts` file on WSL to include a record for raspberrypi.local.

## Nice terminal 

To have a nice terminal, like the one on WSL2, do the following: 

```
scp ~/.p10k.zsh janhein@raspberrypi.local:~
ssh janhein@raspberrypi.local 'bash setup-zsh-on-pi.sh'
```
