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
- pyenv 
- uv

Tested releases:
- Ubuntu26.06 LTS (AMD64)
- Ubuntu24.04 LTS (Docker devcontainer, only `--essentials` tested)

TODO:
- make the installation architecture independent (use env variable or options)
- [Urgent] INSTALL UBUNTU DRIVERS AND NVIDIA DRIVERS 
- there is much bloat, create a minimal set of installs
- audit each install function: confirm which commands really need root and keep `sudo` only on those (`sudo -v` at the start only caches the password, it does not elevate commands without `sudo`)

### Command to run full install
Intended usage is from ~/Downloads folder
```
bash ./bootstrap.sh --all
bash ./templates.sh

\\ You can run a single install as
sudo bash ./scripts/<install_file>.sh
```
Run as your normal user, not with `sudo`: the script calls `sudo` itself for the steps that need root (apt, snap, writing to /etc and /usr/local/bin) and asks for your password once. Per-user tools (pyenv, claude code, templates) install into your home.

Optionally, convert old `.list` apt sources to the deb822 `.sources` format.
**Only on Ubuntu 26.04 (or 25.10+)**: `modernize-sources` needs apt 3.x and fails on 24.04 with `E: Invalid operation modernize-sources`.
Note: it may duplicate existing sources, so check `/etc/apt/sources.list.d/` afterwards.
```
sudo apt modernize-sources
```
### Git Alias and config
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
### Extra
Notes:
If you want to spawn as child shell
```bash <filename>```
