# Installation

* git clone git@github.com:radekmorytko/dotfiles.git
* `cd dotfiles && ./install`
* change window manager (https://askubuntu.com/questions/143376/how-to-change-the-xfce4-default-window-manager)

# Tests

* create the docker image in `tests`: `docker build --tag radek_ubuntu .`
* run a container:
```
docker run --rm -it -v `pwd`:/work radek_ubuntu
```

* copy files to avoid any issues with git
```
cd / && rm -rf $HOME/myrepo/ && cp -r /work $HOME/myrepo && cd $HOME/myrepo && ./install
```
