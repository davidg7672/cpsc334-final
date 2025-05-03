#!/bin/sh

set -e

TEMP_DIR=temp
PKG_NAME=merge-sort
VERSION=1.0.1

echo "Starting deb package build"

# Clean and create directory tree
rm -rf $TEMP_DIR
mkdir -p $TEMP_DIR/DEBIAN
mkdir -p $TEMP_DIR/usr/bin
mkdir -p $TEMP_DIR/etc
mkdir -p $TEMP_DIR/lib/systemd/system
mkdir -p $TEMP_DIR/usr/share/doc/$PKG_NAME

echo "Copying control and maintainer scripts"
cp services/DEBIAN/control $TEMP_DIR/DEBIAN/
cp services/DEBIAN/postinst $TEMP_DIR/DEBIAN/
cp services/DEBIAN/prerm $TEMP_DIR/DEBIAN/
cp services/DEBIAN/postrm $TEMP_DIR/DEBIAN/

# Fix maintainer script permissions
chmod 755 $TEMP_DIR/DEBIAN/postinst
chmod 755 $TEMP_DIR/DEBIAN/prerm
chmod 755 $TEMP_DIR/DEBIAN/postrm

echo "Copying configuration and binary"
cp bin/merge.conf $TEMP_DIR/etc/
cp bin/main.py $TEMP_DIR/usr/bin/main  # Renaming to remove .py extension

# Add proper shebang to main.py if not already there
# sed -i '1s|^|#!/usr/bin/env python3\n|' $TEMP_DIR/usr/bin/main
sed -i '' '1s|^|#!/usr/bin/env python3\n|' "$TEMP_DIR/usr/bin/main"


chmod 755 $TEMP_DIR/usr/bin/main

echo "Copying systemd service"
cp bin/merge.service $TEMP_DIR/lib/systemd/system/
chmod 644 $TEMP_DIR/lib/systemd/system/merge.service

# Add conffiles for Lintian
cat <<EOF > $TEMP_DIR/DEBIAN/conffiles
/etc/merge.conf
/lib/systemd/system/merge.service
EOF

# Create minimal changelog
cat <<EOF > $TEMP_DIR/usr/share/doc/$PKG_NAME/changelog
$PKG_NAME ($VERSION) stable; urgency=low

  * Initial release

 -- David Sosa <you@example.com>  $(date -R)
EOF
gzip -9n $TEMP_DIR/usr/share/doc/$PKG_NAME/changelog

# Create minimal copyright
cat <<EOF > $TEMP_DIR/usr/share/doc/$PKG_NAME/copyright
Copyright (c) 2025 David Sosa
License: MIT
EOF

# Fix file permissions
chmod 644 $TEMP_DIR/etc/merge.conf
chmod 644 $TEMP_DIR/usr/share/doc/$PKG_NAME/*

echo "Building .deb package"
dpkg-deb --root-owner-group --build $TEMP_DIR
mv $TEMP_DIR.deb ${PKG_NAME}-v${VERSION}.deb

echo "Debian package built: ${PKG_NAME}-v${VERSION}.deb"
