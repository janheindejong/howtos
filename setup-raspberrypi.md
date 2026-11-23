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

To make life easy, update your `/etc/hosts` file on WSL to include a record for raspberrypi.local.

## Nice terminal 

To have a nice terminal, like the one on WSL2, do the following: 

```
scp ~/.p10k.zsh janhein@raspberrypi.local:~
ssh janhein@raspberrypi.local 'bash setup-zsh-on-pi.sh'
```

## Tools 

I've got several things running on the Pi: 

* pihole - DNS that catches all kinds of weird traffic
* defense-news - multiple services related to defense news... see ~/source/defense-news-feed
* tailscale - local VPN

## Pihole 

Pi-hole is a network-wide DNS sinkhole. It answers DNS queries for all devices on the LAN and blocks known ad and tracker domains.

- **Install:** `curl -sSL https://install.pi-hole.net | bash`. 
- **Network:** configure the router to use the pi as DNS server
- **Admin UI:** `http://<pi-ip>/admin`. Reset the password with `pihole setpassword`.
- **Upstream DNS:** Set in the web UI under Settings → DNS (for example Quad9 or Cloudflare). Pi-hole forwards allowed queries there.
- **Blocklists:** Manage under Adlists, then run `pihole -g` (update gravity) to apply changes.
- **Allow/deny:** Whitelist false positives under Domains. Check the Query Log to see what was blocked.
- **Maintenance:** `pihole -up` updates it, `pihole status` checks it, and `pihole -r` repairs or reconfigures it.
- **Fallback:** If the Pi is down, DNS stops working for the whole network. Temporarily set the router's DNS to 1.1.1.1 or 9.9.9.9 to recover.

## Tailscale 

Tailscale runs on my raspberry pi, making it accessible from other devices in my tailscale network. 
For more info, see the [tailscale console](https://console.tailscale.com/admin/machines).
