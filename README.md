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

## Command to run full install
```
sudo bash ./bootstrap.sh --all
sudo bash ./templates.sh
```

If you want to spawn as child shell
bash filename
