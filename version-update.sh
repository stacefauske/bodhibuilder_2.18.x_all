#!/bin/bash
#

# used to update the version number throughout the necessary files in bodhibuilder
#   usr/share/bodhibuilder-gtk/bodhibuilder-gtk.py:APP_VERSION = "2.1.0"
#   etc/bodhibuilder/bodhibuilder.version:BODHIBUILDERVERSION="2.1.0"
#   DEBIAN/control:Version: 2.1.0
#   

curr_version=`cat ./etc/bodhibuilder/bodhibuilder.version | cut -d\" -f2`
curr_major_version=`echo ${curr_version} | cut -d. -f1-2`
curr_minor_version=`echo ${curr_version} | cut -d. -f3`
next_minor_version=$((curr_minor_version + 1))

if [ ! "${1}" ] ; then # just echo out the version number
  echo ""
  echo " Current bodhibuilder version is :  ${curr_version}"
  echo ""
  echo " Example to change to the next minor version :"
  echo "   sudo ./version-update.sh 2.18.${next_minor_version}"
  echo ""
else # change version number throughout files
  echo ""
  echo "usr/share/bodhibuilder-gtk/bodhibuilder-gtk.py"
  grep 'APP_VERSION = \".*\"$' ./usr/share/bodhibuilder-gtk/bodhibuilder-gtk.py
  echo "  changed to"
  sed -i "s/APP_VERSION = \".*\"$/APP_VERSION = \"${1}\"/" ./usr/share/bodhibuilder-gtk/bodhibuilder-gtk.py
  grep 'APP_VERSION = \".*\"$' ./usr/share/bodhibuilder-gtk/bodhibuilder-gtk.py
  
  echo ""
  echo "etc/bodhibuilder/bodhibuilder.version"
  grep 'BODHIBUILDERVERSION=\".*\"$' ./etc/bodhibuilder/bodhibuilder.version
  echo "  changed to"
  sed -i "s/BODHIBUILDERVERSION=\".*\"$/BODHIBUILDERVERSION=\"${1}\"/" ./etc/bodhibuilder/bodhibuilder.version
  grep 'BODHIBUILDERVERSION=\".*\"$' ./etc/bodhibuilder/bodhibuilder.version
  
  echo ""
  echo "DEBIAN/control"
  grep 'Version:.*$' ./DEBIAN/control
  echo "  changed to"
  sed -i "s/Version:.*$/Version: ${1}/" ./DEBIAN/control
  grep 'Version:.*$' ./DEBIAN/control
  
  curr_version=`cat ./etc/bodhibuilder/bodhibuilder.version | cut -d\" -f2`
  echo ""
  echo " NEW bodhibuilder version is :  ${curr_version}"
fi

exit 0
