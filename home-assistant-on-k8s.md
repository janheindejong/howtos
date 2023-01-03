# Deploying Home Assistant on k8s 

Apply the k8s manifests: 

``` 
kubectl apply -f manifests/home-assistant.yaml
```

This mounts the folder `/home/janhein/home-assistant`, and Home Assistant places all of its data here, including the `configuration.yaml` file. 

Since we are running Home Assistant behind an Ingress controller that acts as a proxy, and HA blocks this by default, we need to enable it. Add these lines to the configuration file: 

``` 
http:
  use_x_forwarded_for: true
  trusted_proxies:
    - 10.42.0.0/24
```

That should do it! 
