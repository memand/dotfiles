#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# set the cursor
xsetroot -cursor_name left_ptr

# set Danish keyboard layout
setxkbmap dk

# set capslock to be escape
setxkbmap -option caps:escape

# start syndaemon and make it monitor for keyboard acivity and disable toutchpad tapping accordingly
syndaemon -t -k -i 0.5 -d &

# start xmonad
exec xmonad
