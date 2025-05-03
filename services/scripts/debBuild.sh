#!/bin/sh

set -e

PKG_NAME=merge-sort
VERSION=1.0.1
TEMP_DIR=temp

echo "Starting deb package build"

# Clean and create directory tree
rm -rf $TEMP_DIR
mkdir -p $TEMP_DIR/DEBIAN
mkdir -p $TEMP_DIR/usr/bin
mkdir -p $TEMP_DIR/etc
mkdir -p $TEMP_DIR/lib/systemd/system
mkdir -p $TEMP_DIR/usr/share/doc/$PKG_NAME

# CONTROL FILES
cp services/DEBIAN/control $TEMP_DIR/DEBIAN/
cp services/DEBIAN/postinst $TEMP_DIR/DEBIAN/
cp services/DEBIAN/prerm $TEMP_DIR/DEBIAN/
cp services/DEBIAN/postrm $TEMP_DIR/DEBIAN/

chmod 755 $TEMP_DIR/DEBIAN/postinst
chmod 755 $TEMP_DIR/DEBIAN/prerm
chmod 755 $TEMP_DIR/DEBIAN/postrm

# CONFIG FILE
cp bin/merge.conf $TEMP_DIR/etc/
chmod 644 $TEMP_DIR/etc/merge.conf

# PYTHON SCRIPT (rename to no .py and add shebang if needed)
cp bin/main.py $TEMP_DIR/usr/bin/main
# sed -i '' '1s|^|#!/usr/bin/env python3\n|' $TEMP_DIR/usr/bin/main  # macOS-safe
sed -i '1s|^|#!/usr/bin/env python3\n|' "$TEMP_DIR/usr/bin/main"

chmod 755 $TEMP_DIR/usr/bin/main

# SYSTEMD SERVICE
cp bin/merge.service $TEMP_DIR/lib/systemd/system/
chmod 644 $TEMP_DIR/lib/systemd/system/merge.service

# CONFFILES — only mark /etc config files!
echo "/etc/merge.conf" > $TEMP_DIR/DEBIAN/conffiles

# CHANGELOG
cat <<EOF > $TEMP_DIR/usr/share/doc/$PKG_NAME/changelog
$PKG_NAME ($VERSION) stable; urgency=low

  * Initial release

 -- David Sosa <you@example.com>  $(date -R)
EOF
gzip -9n $TEMP_DIR/usr/share/doc/$PKG_NAME/changelog

# COPYRIGHT
cat <<EOF > $TEMP_DIR/usr/share/doc/$PKG_NAME/copyright
Copyright (c) 2025 David Sosa
License: MIT
EOF
chmod 644 $TEMP_DIR/usr/share/doc/$PKG_NAME/*

# BUILD
dpkg-deb --root-owner-group --build $TEMP_DIR
mv $TEMP_DIR.deb ${PKG_NAME}-v${VERSION}.deb

echo "Debian package built: ${PKG_NAME}-v${VERSION}.deb"
