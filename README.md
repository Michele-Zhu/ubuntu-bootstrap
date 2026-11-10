### README
This is a set of scripts that makes easy for me to install a Ubuntu machine and get it ready for my needs. 
Goal: make it modular so I can only install what is need (different scripts per chunky program/config), a main script that runs the childs.
Also for considency I'm trying to get everything done with apt

Target to automate:
- git alias
- cli tools
- gnome configuration
- tmux
- yq, glab, git-lfs
- pyenv (deprecated)
- uv

Tested releases:
- Ubuntu26.06 LTS (AMD64)

TODO:
- make the installation architecture independent (use env variable or options)
- [Urgent] INSTALL UBUNTU DRIVERS AND NVIDIA DRIVERS 

## Command to run full install
```
sudo bash ./bootstrap.sh --all
sudo bash ./templates.sh
```
## Git Alias and config
Aliases are stored under the file /.gitconfig
```
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
```
```
git config --global user.name "<username>"
git config --global user.email "<email>"
git config --global user.name
git config --global user.email
```
## Extra
Notes:
If you want to spawn as child shell
```bash <filename>```
