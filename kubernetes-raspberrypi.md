# Installing Kubernetes on my Raspberry Pi 


## Setting up the Pi 

To identify ourselves for SSH, we can use an SSH key-pair. If you don't already have one, you can create one: 

* Run ssh-keygen -t rsa
* Use the default file `~/.ssh/rsa_id`, and choose a passphrase; this will be your way to identify yourself to other machine

The Pi runs an image that is loaded onto an SSD card. Raspberry Pi has images software to create images.
 
* Select the OS; be sure to select Ubuntu server, not desktop
* Click on the "cog", and change the default settings
    * Choose a hostname, username and password
    * Disable password login, and enable SSH keypair login; use the public part of the keypair you just created 
* Create the image 

You should now be able to login to the raspberry pi through `ssh username@raspberrypi.local`. I've had some issues with mDNS on Windows, running `dns-sd.exe -G v4 <hostname>.local` fixed it. Don't know why... 

To be safe, it's usually a good idea to change the SSH default port. Typically, the SSH daemon service is configured by modifying `/etc/ssh/sshd_config`, but the latest version of Ubuntu uses a socket system, that triggers the start of the service once a request comes in. To set the port, modify ` /etc/systemd/system/ssh.socket.d/listen.conf`: 

``` 
cat > /etc/systemd/system/ssh.socket.d/listen.conf <<EOF
[Socket]
ListenStream=
ListenStream=12345
EOF
```

## Setting up Kubernetes 

Next, we'll install Kubernetes. There's several options out the (Minikube, microk8s), but we'll use k3s. This is an [interesting article](https://anthonynsimon.com/blog/kubernetes-cluster-raspberry-pi/). 

Install k3s: 

```
curl -sfL https://get.k3s.io | sh -`
sudo apt install linux-modules-extra-raspi
```   

Configure kubectl: 

```
cat >> ~/.profile <<EOF 
export KUBECONFIG="$HOME/.kube/config"
EOF
cat /etc/rancher/k3s/k3s.yaml > "$HOME/.kube/config" 
```

