#!/bin/sh

TEMP=temp

echo "Starting deb package build"

echo "Making temporary directory tree"
mkdir -p $TEMP
mkdir -p $TEMP/etc/
mkdir -p $TEMP/etc/bin/
mkdir -p $TEMP/DEBIAN/
mkdir -p $TEMP/etc/systemd/system

echo "Copy control file DEBIAN"
cp services/DEBIAN/control $TEMP/DEBIAN/

echo "Copying postinst, prerm, and postrm scripts"
cp services/DEBIAN/postinst $TEMP/DEBIAN/
cp services/DEBIANprerm $TEMP/DEBIAN/
cp services/DEBIAN/postrm $TEMP/DEBIAN/

echo "Configuration file into place"
cp bin/merge.conf $TEMP_DIR/etc/

echo "Copying main.cpp"
cp /bin/main.cpp $TEMP_DIR/usr/bin/

echo "Moving merge.service file"
cp bin/merge.service $TEMP/etc/systemd/system

echo "Building deb file"
dpkg-deb --root-owner-group --build $TEMP
mv $TEMP.deb merge-sort-v1.0.1.deb

chmod 755 ${TEMP_DIR}/etc/
chmod 755 ${TEMP_DIR}/etc/systemd/
chmod 755 ${TEMP_DIR}/etc/systemd/system
chmod 755 ${TEMP_DIR}/etc/systemd/system/merge.service
chmod 755 ${TEMP_DIR}/usr/
chmod 755 ${TEMP_DIR}/usr/bin/
chmod 755 ${TEMP_DIR}/usr/bin/main.cpp
chmod 755 ${TEMP_DIR}/etc/merge.conf

echo "deb package built"
