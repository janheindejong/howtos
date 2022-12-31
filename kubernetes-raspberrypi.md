# Installing Kubernetes on my Raspberry Pi 


This is an [interesting article](https://anthonynsimon.com/blog/kubernetes-cluster-raspberry-pi/). 

* Create SSH key-pair (if you don't already have one): 
    * Run ssh-keygen -t rsa
    * Use the default file `~/.ssh/rsa_id`, and choose a passphrase; this will be your way to identify yourself to other machines 
* Use raspberry pi imager to create new Ubuntu image on SSD card 
    * Download the imager 
    * Select the OS, be sure to select Ubuntu server, not desktop
    * Click on the "cog"
    * Choose a hostname, username and password
    * Disable password login, and enable SSH keypair login; use the public key you just created 
    * Create the image 

You should now be able to login to the raspberry pi through `ssh username@raspberrypi.local`. I've had some issues with mDNS on Windows, running `dns-sd.exe -G v4 <hostname>.local` fixed it. Don't know why... 
 
