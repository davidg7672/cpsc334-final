#!/bin/sh

TEMP_DIR=temp

echo "Starting deb package build"

echo "Making temporary directory tree"
mkdir -p $TEMP_DIR
mkdir -p $TEMP_DIR/etc/
mkdir -p $TEMP_DIR/usr/bin/
mkdir -p $TEMP_DIR/DEBIAN/
mkdir -p $TEMP_DIR/etc/systemd/system

echo "Copying control file"
cp services/DEBIAN/control $TEMP_DIR/DEBIAN/

echo "Copying postinst, prerm, and postrm scripts"
cp services/DEBIAN/postinst $TEMP_DIR/DEBIAN/
cp services/DEBIAN/prerm $TEMP_DIR/DEBIAN/
cp services/DEBIAN/postrm $TEMP_DIR/DEBIAN/

echo "Copying configuration file"
cp bin/merge.conf $TEMP_DIR/etc/

echo "Copying main.py"
cp bin/main.py $TEMP_DIR/usr/bin/

echo "Copying merge.service file"
cp bin/merge.service $TEMP_DIR/etc/systemd/system/

echo "Setting permissions"
# Set executable permissions for maintainer scripts
chmod 755 ${TEMP_DIR}/DEBIAN/postinst
chmod 755 ${TEMP_DIR}/DEBIAN/prerm
chmod 755 ${TEMP_DIR}/DEBIAN/postrm

# Other files and directories
chmod 755 ${TEMP_DIR}/etc/
chmod 755 ${TEMP_DIR}/etc/systemd/
chmod 755 ${TEMP_DIR}/etc/systemd/system/
chmod 755 ${TEMP_DIR}/etc/systemd/system/merge.service

chmod 755 ${TEMP_DIR}/usr/
chmod 755 ${TEMP_DIR}/usr/bin/
chmod 755 ${TEMP_DIR}/usr/bin/main.py
chmod 755 ${TEMP_DIR}/etc/merge.conf

echo "Building deb package"
dpkg-deb --root-owner-group --build $TEMP_DIR
mv $TEMP_DIR.deb merge-sort-v1.0.1.deb

echo "deb package built"
