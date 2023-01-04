# Deploying Home Assistant on k8s 

This describes how I've deployed and setup Home Assistant on my [Raspberry Pi hosted Kubernetes cluster](./K8s-on-raspberrypi.md).

## Deploying

Apply the [manifest](./manifests/home-assistant.yaml): 

``` 
kubectl apply -f manifests/home-assistant.yaml
```

This mounts the folder `/home/home-assistant`, and Home Assistant places all of its data here, including the `configuration.yaml` file. 

Since we are running Home Assistant behind an Ingress controller that acts as a proxy, and HA blocks this by default, we need to enable it. Add these lines to the configuration file: 

``` 
http:
  use_x_forwarded_for: true
  trusted_proxies:
    - 10.42.0.0/24
```

That should do it! 
