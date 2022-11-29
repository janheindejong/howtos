# Windows developer machine 

This How-To describes how to setup my development Windows development machine. 

## Chocolatey 

I install most stuff through Chocolatey. Follow the official instructions to install it. 

## VIM 

I like to use Vim as editor.

```powershell 
choco install vim 
```

By default, vim writes annoying temp files next to the files you are editing. You can configure it to save these files to a central location. Open vim, and run: 

```vim 
:e $MYVIMRC
```

Add the following lines: 

```vimrc
set dir=C:\temp
set undodir=C:\temp
set backupdir=C:\temp
```

## Kubernetes

To install minikube and kubectl on Windows, it's easiest to use Chocolatey. 

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

## Oh-my-posh & posh-git

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
