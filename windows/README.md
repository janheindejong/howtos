# Kubernetes deployment 

This contains the code to deploy a k8s environment to my local Windows machine using minikube. 

To install minikube and kubectl on Windows, it's easiest to use Chocolatey. After which, you can simply run: 

```powershell 
choco install kubectl 
choco install minikube
```

Next, it's nice to add autocompletion to kubectl. For this, add this line to `$PROFILE`: 

```powershell
kubectl completion powershell | Out-Null | Invoke-Expression
```

Next, we can start minikube, and enable some addons: 

```powershell 
minikube start 
minikube addons enable ingress
minikube addons enable metrics-server
```

Posh-git and oh-my-posh are nice additions: 

```powershell 
PowerShellGet\Install-Module posh-git -Scope CurrentUser -Force
winget upgrade JanDeDobbeleer.OhMyPosh -s winget
oh-my-posh install font # Choose Mesmo
```

Set terminal to use nerdfont: 

```json 
{
    "profiles":
    {
        "defaults":
        {
            "font":
            {
                "face": "MesloLGM NF"
            }
        }
    }
}
```

Add the following lines to `$PROFILE`: 

```powershell
Import-Module posh-git
oh-my-posh init pwsh | Invoke-Expression
```

There's many many themes for it, but I like stelbent-compact.minimal: 

```powershell 
oh-my-posh init pwsh --config $env:POSH_THEMES_PATH\stelbent-compact.minimal | Invoke-Expression
```
