# Managed files
- \~/.i3/config
- \~/.xinitrc

# By hostname specific configuration in config file
Add a dir named as hostname in by_host dir to include specific host configuration in config file
```
mkdir templates/by_host/$(hostname)
echo "#To include in config file" > templates/by_host/$(hostname)/config.j2
```

# By OS specific configuration for config file
Add a dir named as OS in by_os to include specific host configuration in config file
```
mkdir templates/by_os/<archlinux|centos|debian>
echo "#To include in config file" > templates/by_os/<archlinux|centos|debian>/config.j2
```
