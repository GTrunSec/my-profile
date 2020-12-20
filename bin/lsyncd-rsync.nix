{ }:
''
  pkill -f lsyncd
  lsyncd -rsync \
   /home/gtrun/.config/nixpkgs/dotfiles/wallpaper/.attach /var/lib/photoprism/import/wallpaper-backup
''
