# i3-gaps Acid Dark 

|           |               |
|-----------|:-------------:|
|   Master  | [![Build Status](https://travis-ci.org/eoli3n/dotfiles.svg?branch=master)](https://travis-ci.org/eoli3n/dotfiles) |
|    Dev    | [![Build Status](https://travis-ci.org/eoli3n/dotfiles.svg?branch=dev)](https://travis-ci.org/eoli3n/dotfiles) |

**i3-gaps zsh pureprompt polybar**

![alt tag](https://github.com/eoli3n/dotfiles/blob/master/screenshots/i3gaps.png)

**Weechat**

![alt tag](https://github.com/eoli3n/dotfiles/blob/master/screenshots/weechat.png)

**Chrome Rofi Stylish**

![alt tag](https://github.com/eoli3n/dotfiles/blob/master/screenshots/chrome-rofi.png)

**Connman GTK Theme**

![alt tag](https://github.com/eoli3n/dotfiles/blob/master/screenshots/connman-gtk.png)

## How to
Ansible allows to duplicate this Desktop Environment over multiple hosts with specific configuration (dualscreen, packages...).

**Fork Me!** Please look at ``roles/*/README.md`` if exists for specific hosts configuration.

**!!! Use as is, you will add my SSH key in your authorized_keys !!!**

To disable that role, please run :
```
cd dotfiles
sed -i 's/^\(.*authorized_keys.*\)$/#\1/' install.yml
```

## Test VMs|Containers
Please check ``vagrant/*/README.md`` and ``docker/*/README.md``

## Desktop/Laptop Environment

Don't run as ``root``.

### Supported OS

- Archlinux

### Dependencies

- ansible >= 2.4
- packer

```
sudo pacman -S jshon ansible
curl -o PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=packer-git; makepkg PKGBUILD --install --needed --noconfirm
```

### Role list

- package-common
- screen
- ssh-agent
- authorized_keys
- terminfo
- vim
- zsh
- package-desktop
- compton
- cursor
- gtk
- i3-wm
- neofetch
- polybar
- rofi
- termite
- weechat
- packages-laptop [only laptop tag]
- xbindkeys [only laptop tag]

### Installation
[WARNING] Use carefully, backup your home before using !
Ansible will backup any existing conf file before erasing it (.zshrc, .i3/config, etc...)
```
git clone --recursive https://github.com/eoli3n/dotfiles
cd dotfiles
# To list tasks, dryrun then install
./install.sh <desktop|laptop|[any package tag]>
```

### Manual configurations

**Google chrome**

Open this link to set lighter scrollbar
```
chrome://flags/#overlay-scrollbars
```
To use dark theme, go to graphical configuration and click ``Use GTK+ Theme``

## Server Environment

``server`` tag limits to install/configure cli tools. It could be run as ``root``.

### Supported OS

- Archlinux
- Debian
- Centos
- FreeBSD : need to ``sudo ln -s /usr/local/bin/python2 /usr/bin/python``

### Dependencies

- ansible >= 2.4

### Role list

- package-common
- screen
- terminfo
- vim
- zsh
- authorized_keys

## Installation

```
git clone --recursive https://github.com/eoli3n/dotfiles
cd dotfiles
# To list tasks, dryrun then install
./install.sh <server|[any package tag]>

```

# Previously

* [i3-gaps Dark Solarized](https://github.com/eoli3n/dotfiles/tree/zsh-agnoster-solarized)

**IRC**

eoli3n @ freenode #archlinux-fr
