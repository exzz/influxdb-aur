# Description

Build influxdb package on archlinux

# Package

## Build pacman package

Git clone this repo and run the following command
```
makepkg .
```

Install new package 
```
sudo pacman -U influxdb-VERSION-x86_64.pkg.tar.xz
```

## Build AUR source package

```
makepkg --source
```

Upload influxdb-VERSION-SUBVERSION.src.tar.gz to AUR repository
