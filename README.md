# NixOS

**configuration.nix**
**flake.nix**
**home.nix**

Must need to be in **/etc/nixos/** (Tips, be in sudo cause these file are not writable in user mode)
also don't forget to change the username and the machine name (vaelen is the username and foxdroid is the machine name)
in the **configuration.nix**
***device = "/dev/disk/by-uuid/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx";***
the "x" must be replace by the id of your disk
Also don't forget to change the timezone below the disk init


# Niri (Wayland)
**config.kdl** in the niri folder must be place in **~/.config/niri/**
also reminder to change the output in the file, the resolution and framerate (also the keyboard, i use caps lock to change the layout between french, english and russian)

# Mako (Notification)
This is my style, this file must be place in **~/.config/mako/**

# Fuzzel (App Drawer)
This is my style, this file must be place in **~/.config/fuzzel/**

# Neovim (Yes)
Probably a hard config but wtv it's working like i wanted,
must be placed in **~/.config/nvim/**
