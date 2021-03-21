My .dotfile repo containing all relevant configurations that I use.

To use the post-install script for Ubuntu ssh into the Ubuntu server and type:
```bash
wget -O /etc/init.d/ubuntuPostInstall.sh https://raw.githubusercontent.com/Vanderscycle/ubuntu-dot-config/main/postInstallScripts/ubuntuPostInstall.sh && chmod +x /etc/init.d/ubuntuPostInstall.sh && bash /etc/init.d/ubuntuPostInstall.sh
``` 
It will however require a reboot.

The post install script installs the following programs:
* Postgresql
* MongoDB
* Docker
* Miniconda
* Oh-my-zsh (p10k theme)