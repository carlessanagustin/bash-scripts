#!/bin/bash -x


function postinstall_sysadmin_libvirt {
  [[ ! -d /srv/lib/libvirt ]] && mkdir -p /srv/lib/libvirt
  [[ ! -d /var/lib/libvirt ]] && ln -s /srv/lib/libvirt /var/lib/libvirt
  apt install libvirt-daemon libvirt-daemon-system libvirt-clients virt-top xmlstarlet uuid-runtime -y
}

function postinstall_sysadmin_libvirt_modprobe {
  case $( cat /proc/cpuinfo | fgrep vendor_id | head -1 | sed -E 's/[ \t]+/ /g' | cut -d' ' -f3 ) in
    AuthenticAMD) local cpu=amd   ;;
    GenuineIntel) local cpu=intel ;;
    *) local cpu=unknown ;;
  esac

  # shake the tree
  rmmod kvm_${cpu}
  rmmod kvm
  modprobe kvm
  modprobe kvm_${cpu}
}

postinstall_sysadmin_libvirt && postinstall_sysadmin_libvirt_modprobe
