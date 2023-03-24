#!/usr/bin/sh

# from /etc/X11/xinit/xinitrc
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi
# --- end /etc/X11/xinit/xinitrc ---

# status bar
slstatus &
# set background image
feh --bg-scale /usr/share/backgrounds/archlinux/landscape.jpg
setxkbmap -layout us,th -option grp:ctrls_toggle
xcompmgr &
# hide mouse when not useing it
unclutter &
exec dwm >> $HOME/.log/dwm/$(date +%F).log 
