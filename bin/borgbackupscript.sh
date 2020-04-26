#! /bin/sh
renice -n 19 -p $$ > /dev/null

# check if we are run by root
[ `whoami` != "root" ] && printf "Run the program as root\n" && exit 1

# check if drive is mounted
[ ! -d /run/media/jagan/j605_hdd ] && printf "Backup drive not mounted\n" && exit 1

BACKUP_DIR=/run/media/jagan/j605_hdd/Backups-borg
DATE=$(date +%F)
BORG_OPTS="--stats --progress --compression auto,zstd --checkpoint-interval 86400"

borg create $BORG_OPTS \
  --exclude /home/jagan/books \
  --exclude /home/jagan/Dropbox \
  --exclude /home/jagan/.cache \
  --exclude /home/jagan/.thumbnails \
  --exclude /home/jagan/alt-speed-enabled \
  --exclude /home/jagan/srces \
  --exclude /home/jagan/snap \
  --exclude /home/jagan/.gnupg \
  --exclude /home/jagan/Music \
  --exclude /home/jagan/.config/chromium \
  --exclude /home/jagan/.mozilla \
  --exclude /home/jagan/.mozbuild \
  --exclude /home/jagan/.dropbox-dist \
  --exclude /home/jagan/Podcasts \
  --exclude /home/jagan/.ccache \
  --exclude /home/jagan/.cache/sccache \
  --exclude /home/jagan/dotfiles \
  --exclude /home/jagan/.eclipse \
  --exclude /home/jagan/.cargo \
  --exclude /home/jagan/.npm \
  --exclude /home/jagan/.yarn \
  --exclude /home/jagan/.node-gyp \
  --exclude /home/jagan/.rustup \
  --exclude /home/jagan/.ACEStream \
  --exclude /home/jagan/.local/share/baloo \
  --exclude /home/jagan/esat \
  --exclude "/home/lost+found" \
  --exclude /dev \
  --exclude /proc \
  --exclude /sys \
  --exclude /tmp \
  --exclude /run \
  --exclude /media \
  --exclude /mnt \
  --exclude /var/cache \
  --exclude /var/lib/aurbuild \
  --exclude "lost+found" \
  $BACKUP_DIR::$DATE \
  /

tput bel

borg create $BORG_OPTS /run/media/jagan/j605_hdd/BorgSync::$DATE \
    /home/jagan/books \
    /home/jagan/srces \
    /media/edx \
    /home/jagan/Music \
    /home/jagan/dotfiles \
    /home/jagan/Podcasts
