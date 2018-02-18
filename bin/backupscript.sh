#! /bin/sh
renice -n 19 -p $$ > /dev/null

# check if we are run by root
[ `whoami` != "root" ] && printf "Run the program as root\n" && exit 1

# check if drive is mounted
[ ! -d /run/media/jagan/j605_hdd ] && printf "Backup drive not mounted\n" && exit 1

export BUP_DIR=/run/media/jagan/j605_hdd/Backups-10022018

bup init
bup fsck --quick -j 4
bup index -u --exclude /home/jagan/books \
  --exclude /home/jagan/Dropbox \
  --exclude /home/jagan/.cache \
  --exclude /home/jagan/.thumbnails \
  --exclude /home/jagan/alt-speed-enabled \
  --exclude /home/jagan/srces \
  --exclude /home/jagan/.gnupg \
  --exclude /home/jagan/Music \
  --exclude /home/jagan/.config/chromium \
  --exclude /home/jagan/.mozilla \
  --exclude /home/jagan/.mozbuild \
  --exclude /home/jagan/.dropbox-dist \
  --exclude /home/jagan/Podcasts \
  --exclude /home/jagan/.ccache \
  --exclude /home/jagan/dotfiles \
  --exclude /home/jagan/.eclipse \
  --exclude /home/jagan/.cargo \
  --exclude /home/jagan/.npm \
  --exclude /home/jagan/.rustup \
  --exclude /home/jagan/esat \
  --exclude "/home/lost+found" \
  --exclude /dev \
  --exclude /proc \
  --exclude /sys \
  --exclude /tmp \
  --exclude /run \
  --exclude /media \
  --exclude /mnt \
  --exclude /var \
  --exclude "lost+found" \
  /
bup save -n kup /
bup fsck -g -j 4

unset BUP_DIR

rsync -aR --delete --delete-excluded \
    /home/jagan/books \
    /home/jagan/srces \
    /media/edx \
    /home/jagan/Music \
    /home/jagan/dotfiles \
    /home/jagan/Podcasts /run/media/jagan/j605_hdd/SyncedStuff
