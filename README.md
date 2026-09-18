# My NixOS Configuration
My dendritic NixOS config

## Inspired by:
- https://github.com/ebadfd/nix-config
- https://github.com/Linuxury/nixos-config
- https://github.com/DoctorDalek1963/nixos-config
- https://github.com/BreadOnPenguins/scripts
- https://tduyng.com (neovim)
- https://github.com/shebpamm/dots-nix

## Installation
```bash
sudo -i

# Partition Disk (specific to you)
lsblk
cfdisk /dev/sdXXX
lsblk

# Format Partitions (specific to you)
mkfs.ext4 -L nixos /dev/sda3
mkswap -L swap /dev/sda2
swapon /dev/disk/by-label/swap
mkfs.fat -F 32 -n boot /dev/sda1

# Mount Everything
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount -o umask=077 /dev/disk/by-label/boot /mnt/boot

# Choose user and host
export HOST=lenovo
export NIXUSER=steve

# Clone config
mkdir -p /mnt/home/$NIXUSER
git clone https://github.com/7zo7zo7zo/nixos-config.git /mnt/home/$NIXUSER/nixos-config
chown -R 1000:100 /mnt/home/$NIXUSER/nixos-config

# Symlink to /etc/nixos
mkdir -p /mnt/etc
ln -sf /home/$NIXUSER/nixos-config /mnt/etc/nixos
ls -la /mnt/etc/nixos

# Setup hardware configuration
nixos-generate-config --root /mnt --show-hardware-config \
  > /mnt/home/$NIXUSER/nixos-config/modules/hosts/$HOST/_hardware-configuration.nix
cat /mnt/home/$NIXUSER/nixos-config/modules/hosts/$HOST/_hardware-configuration.nix

# Install 
nixos-install --flake /mnt/home/$NIXUSER/nixos-config#$HOST
nixos-enter --root /mnt -c "passwd $NIXUSER"
reboot
```

## Useful commands
```bash
nix run .#write-flake # whenever you need to regen flake.nix

nix flake check # will make sure your flake.nix is up-to-date
```

## Wallpaper

**Light** by **Zim2687**.

Source: https://www.deviantart.com/zim2687/art/Light-412720633

License: Creative Commons Attribution-NonCommercial-No Derivatives Works 3.0 License
https://creativecommons.org/licenses/by-nc-nd/3.0/
