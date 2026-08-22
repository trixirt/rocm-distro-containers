#!/bin/sh

dnf update -y
rh=`dnf list  | wc | awk '{ print $1 }'`
rh_p=`dnf search python3- | wc | awk '{ print $1 }'`
rh_r=`dnf search rust- | wc | awk '{ print $1 }'`
rh_g=`dnf search golang- | wc | awk '{ print $1 }'`
rh_e=`dnf search perl- | wc | awk '{ print $1 }'`
rh_u=`dnf search ruby- | wc | awk '{ print $1 }'`

echo ""
echo "Fedora Rawhide       python $rh_p rust $rh_r go $rh_g perl $rh_e ruby $rh_u total $rh"



