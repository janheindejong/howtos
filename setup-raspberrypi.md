# Setup Raspberry Pi 

## Fresh install 

First, create a flash SSD using [raspberrypi.com/software](https://raspberrypi.com/software). I used Raspberry Pi OS Lite, since no desktop is needed, and this has the best integration with the hardware. I've used the following config: 

* *hostname*: `raspberrypi`
* *username*: `janhein`
* *password*: beats me? 

Next, transfer the SSD and power up the Pi. You can now find the pi on your local network, by calling: 

```powershell 
ssh janhein@raspberrypi.local
```

Note: discovery of the mDNS `raspberrypi.local` currently (Apr 2026) doesn't work from WSL. There's ways to fix it, by disabling `dnsTunneling`, but I don't want to go there just yet. For now, resolve the DNS by calling `ping -4 raspberrypi.local` in Windows Powershell, and use it instead of the hostname. 
