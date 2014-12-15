#!/usr/bin/env bash

source PKGBUILD
echo ">>> Generating AURINFO for $pkgname"
cat > .AURINFO << __EOF__
pkgbase = $pkgname
pkgname = $pkgname
pkgver = $pkgver
pkgrel = $pkgrel
pkgdesc = $pkgdesc
url = $url
license = $license
__EOF__

for i in "${depends[@]}"; do
  echo "depend = $i"
done | sort >> .AURINFO

cat .AURINFO

echo ">>> Generating package source"
mkaurball -f

echo ">>> Uploading to AUR"
aurploader -a
