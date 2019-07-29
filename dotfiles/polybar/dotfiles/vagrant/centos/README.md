# Dependencies

- Vagrant
- Virtualbox

# Provision

This is fully automatised

```
git clone --recursive https://github.com/eoli3n/dotfiles
cd dotfiles
git checkout <master|dev>
cd vagrant/<archlinx|debian|centos|freebsd>
vagrant up
```

# Test

- Launch virtualbox GUI, open VM
- Login in TTY
  - Login : ``vagrant``
  - Password : ``vagrant``
- ``startx``

# Clean after test

- Suppress Virtualbox VM
```
cd ~/dotfiles/vagrant/<archlinx|debian|centos|freebsd>
vagrant destroy
```
- Suppress Vagrant box
```
vagrant box list
vagrant box remove <box>
```
