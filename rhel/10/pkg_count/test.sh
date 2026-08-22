#!/bin/sh

dnf update -y
ss=`dnf list --all | wc | awk '{ print $1 }'`
ss_p=`dnf search python3- | wc | awk '{ print $1 }'`
ss_r=`dnf search rust- | wc | awk '{ print $1 }'`
ss_g=`dnf search golang- | wc | awk '{ print $1 }'`
ss_e=`dnf search perl- | wc | awk '{ print $1 }'`
ss_u=`dnf search ruby- | wc | awk '{ print $1 }'`

dnf install -y \
 https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

dnf update -y
ep=`dnf list --all | wc | awk '{ print $1 }'`
ep_p=`dnf search python3- | wc | awk '{ print $1 }'`
ep_r=`dnf search rust- | wc | awk '{ print $1 }'`
ep_g=`dnf search golang- | wc | awk '{ print $1 }'`
ep_e=`dnf search perl- | wc | awk '{ print $1 }'`
ep_u=`dnf search ruby- | wc | awk '{ print $1 }'`

echo ""
echo "Compare content of CentOS Stream and EPEL"
echo "CentOS Stream        python $ss_p rust $ss_r go $ss_g perl $ss_e ruby $ss_u total $ss"
echo "CentOS Stream + EPEL python $ep_p rust $ep_r go $ep_g perl $ep_e ruby $ep_u total $ep"


