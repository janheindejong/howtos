# Setup Raspberry Pi 

## Fresh install 

First, create a flash SSD using [raspberrypi.com/software](https://raspberrypi.com/software). I 
used Raspberry Pi OS Lite, since no desktop is needed, and this has the best integration with 
the hardware. I've used the following config: 

* *hostname*: `raspberrypi`
* *username*: `janhein`
* *password*: beats me? 

Transfer the SSD to the Pi and power it up. Once running, open the router admin portal, find the 
device, and give it a fixed IP address (`192.168.2.21`). 

```zsh 
ssh janhein@192.168.2.21
```

To make life easy, update your `/etc/hosts` file on WSL to include a record for `raspberrypi.local`.

## Nice terminal 

To have a nice terminal, like the one on WSL2, do the following: 

```
scp ~/.p10k.zsh janhein@raspberrypi.local:~  # Copy settings from WSL2 terminal
ssh janhein@raspberrypi.local 'bash setup-zsh-on-pi.sh'  # Setup the whole thing
```

## Tools 

I've got several things running on the Pi: 

* **pihole** - DNS sinkhole
* **defense-news** - TNO AI Nieuws Analist
* **tailscale** - VPN
* **personal-trainer** - app to manage my sports, with access to Garmin

## Pihole 

Pi-hole is a network-wide DNS sinkhole. It answers DNS queries for all devices on the LAN and blocks known ad and tracker domains.

Install: 

1. Run `curl -sSL https://install.pi-hole.net | bash` on Pi
2. Check on other device in network: `http://pi.hole/admin`; if doesn't work, use explicit IP of Pi. 

Configure: 

1. Configure the router to use the pi as DNS server
2. Upstream DNS: Set in the web UI under Settings → DNS (for example Quad9 or Cloudflare). Pi-hole forwards allowed queries there.
3. Blocklists: Manage under Adlists, then run `pihole -g` (update gravity) to apply changes.
4. Allow/deny: Whitelist false positives under Domains. Check the Query Log to see what was blocked.

Maintenance: 

* `pihole -up` updates it
* `pihole status` checks it
* `pihole -r` repairs or reconfigures it.

## Defense News 

Runs several timed services and perpetual services: 

* defense-news-collect - runs every 6 hours
* defense-news-weekly - runs every monday morning
* defense-news-reader - public webapp, listens on port 8000
* defense-news-admin - admin portal, listens on port 8010

For more info, see `~/source/defense-news-feed`. 

## Tailscale 

Tailscale runs on my raspberry pi, making it accessible from other devices in my tailscale network. 
For more info, see the [tailscale console](https://console.tailscale.com/admin/machines).

## Personal trainer 

Runs several timed and perpetual services: 

* personal-trainer.service - app, listening on port 9000
* personal-trainer-sync.service + .timer - runs every 30 minutes

