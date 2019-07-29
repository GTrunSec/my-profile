# By hostname specific configuration in zshrc
Add a dir named as hostname in by_host dir to include specific host configuration in config file
```
mkdir templates/by_host/$(hostname)
echo << EOF > templates/by_host/$(hostname)/zshrc.j2
# Alias to include for $(hostname)
alias foo=bar
EOF
```

# By OS specific configuration in zshrc
Add a dir named as hostname in by_host dir to include specific host configuration in config file
```
mkdir templates/by_os/<archlinux|debian|centos>
echo << EOF > templates/by_os/<archlinux|debian|centos>/zshrc.j2
# Alias to include for <archlinux|debian|centos>
alias foo2=bar2
EOF
```
