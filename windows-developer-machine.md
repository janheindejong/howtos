# Windows developer machine 

This How-To describes how to setup my development Windows development machine. 

## Chocolatey 

I install most stuff through Chocolatey or Scoop. Follow the official instructions to install them. 

## ViM 

I like to use Vim as editor.

```powershell 
scoop install vim 
```

By default, vim writes annoying temp files next to the files you are editing. You can configure it to save these files to a central location. Open vim, and run: 

```vim 
:e $MYVIMRC
```

You might have to create a file `$HOME\_vimrc`.


Add the following lines: 

```vimrc
set dir=C:\temp
set undodir=C:\temp
set backupdir=C:\temp
set backspace=indent,eol,start
let $LANG = 'en'


# Python configuration 
au BufNewFile,BufRead *.py set
    \ tabstop=4
    \ softtabstop=4
    \ shiftwidth=4
    \ textwidth=88
    \ expandtab
    \ autoindent
    \ fileformat=unix
```

## Git 

I install Git via Scoop. 

```powershell
scoop install git 
git config --global credential.store=manager 
git config --global credential.helper=manager
```


## Enable Hyper-V non-admin access

Open Computer Management; go to System Tools > Local Users and Groups > Groups > Hyper-V admins. Add the user. Done. 

## Kubernetes

To install minikube and kubectl on Windows, it's easiest to use Chocolatey. 

```powershell 
choco install kubectl 
choco install minikube
choco install k9s
```

Next, it's nice to add autocompletion to kubectl. For this, add this line to `$PROFILE`: 

```powershell
kubectl completion powershell | Out-String | Invoke-Expression
```

Next, we can start minikube, and enable some addons: 

```powershell 
minikube start --driver=hyperv 
minikube addons enable ingress
minikube addons enable metrics-server
```

To be able to access the cluster, it's useful to setup a local DNS record, in `C:\windows\system32\drivers\etc\hosts` pointing to the cluster ip (`minikube ip`), e.g.: 

```
192.168.178.118 cluster.minikube.internal
```

Install helm: 

```powershell 
choco install helm
``` 

https://logz.io/blog/deploying-the-elk-stack-on-kubernetes-with-helm/

## Oh-my-posh & posh-git

Posh-git and oh-my-posh are nice additions: 

```powershell 
PowerShellGet\Install-Module posh-git -Scope CurrentUser -Force
scoop install https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/oh-my-posh.json
oh-my-posh font install # Choose Meslo
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
$env:POSH_GIT_ENABLED = $true
```

There's many many themes for it, but I like stelbent-compact.minimal: 

```powershell 
oh-my-posh init pwsh --config $env:POSH_THEMES_PATH\stelbent-compact.minimal.omp.json | Invoke-Expression
```

## Python 

There's a million ways to setup your Python environment, but I like to go with a combination of Python, Pipx and Poetry as a basis. Any other tools I also install, but typically add them to the project dependencies as well. 

First, download and install Python from `python.org`. Next, install pipx: 

``` 
python -m pip install pipx 
pipx ensurepath 
``` 

Next, install and configure Poetry and `poethepoet`: 

```
pipx install poetry 
poetry config virtualenvs.in-project true
poetry self add 'poethepoet[poetry_plugin]'
```

Install any additional tooling: 

``` 
pipx install autoflake8 
pipx install flake8 
pipx install isort 
pipx install mypy 
pipx install black
pipx install pytest 
```

Again, I prefer installing these in the project environment as dev dependencies (since CI pipelines also need these tools), like so: 

```powershell 
poetry add -G dev autoflake8 flake8 isort mypy black pytest
```

## WSL 

To setup a Linux based development experience on Windows, you can use VSCode and WSL. To do this: 

1. Install WSL, and a distro of your liking (e.g. Ubuntu)
2. Install VSCode, and the VSCode WSL plugin 
3. Run `code .` from a folder in a WSL terminal

You'll probably want to upgrade your distro.

```bash
sudo apt update && sudo apt upgrade -y
sudo apt do-release-upgrade 
```

Next, you'll want to setup git, and optionally connect it to your Windows credential manager: 

```bash 
sudo apt update && sudo apt install git -y
git config --global user.name <My Name>
git config --global user.email <name@domain.com>
git config --global credential.helper "/mnt/c/Users/<user>/scoop/apps/git/current/mingw64/bin/git-credential-manager.exe"  # This depends a bit on the version of git you have, google it 
git config --global credential.https://dev.azure.com.useHttpPath true  # This is necessary for working with Azure DevOps based repos 
```

You might want to install and configure Poetry for Python development.

```bash
export POETRY_HOME="~/.local/share/pypoetry"  # Default value
curl -sSL https://install.python-poetry.org | python3 -
```

Add the following lines to `~/.bashrc`, to ensure poetry can always be found. 

```bash
export PATH="$POETRY_HOME/bin:$PATH"
```

I personally like it when Poetry creates the venvs in the folder of the project; this decouples the artifact (i.e. the venv) from the tool you use to make it. It's a cleaner way, that makes it more transparant and easy for other tools to understand what is going on (e.g. your IDE).

```bash 
poetry config virtualenvs.in-project true
```

Finally, if you are going to use MS Azure Artifacts, you'll need to configure authentication for pip. 

```bash
sudo apt update && sudo apt install -y dotnet-sdk-6.0
poetry self add keyring artifacts-keyring
```

Now, you should be all good to go for developing Python on WSL through VSCode! 