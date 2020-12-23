{ }:
''
  killall -q lsyncd &
  PID=$!
  wait $PID
  lsyncd -rsync /home/gtrun/Nextcloud/wallpaper/.attach /var/lib/photoprism/import/wallpaper-backup
  lsyncd -rsync /home/gtrun/Nextcloud/phone /var/lib/photoprism/import/phone-backup
''
