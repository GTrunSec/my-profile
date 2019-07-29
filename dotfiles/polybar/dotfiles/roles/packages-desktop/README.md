# Specific hosts packages
Add a tasks file named with hostname of target 
```
echo <<\EOF > tasks/$(hostname).yml
---
- name: Install $(hostname) packages
  pacman: name={{item}} state=present
  with_items:
    - vim
  become: True
EOF
```

