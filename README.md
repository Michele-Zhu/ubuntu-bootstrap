### README
This is a set of scripts that makes easy for me to install a Ubuntu machine and get it ready for my needs. 
Goal: make it modular so I can only install what is need (different scripts per chunky program/config), a main script that runs the childs.
Also for considency I'm trying to get everything done with apt

Target to automate:
- git alias
- cli tools
- slack/discord 
- gnome configuration
- tmux
- linux templates

## Command to run full install
```
sudo bash ./bootstrap.sh --all
```

If you want to spawn as child shell
bash filename
