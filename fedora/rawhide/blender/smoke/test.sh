#!/bin/sh
# Copied from
# hhttps://gist.github.com/cgmb/44e19790dbef0ecad322a8fc86000455

wget --continue https://download.blender.org/demo/test/classroom.zip
unzip classroom.zip
blender -b classroom/classroom.blend -o $HOME/class_gfx_ -f 0 -F PNG -x 1  -- --cycles-device HIP --cycles-print-stats --offline-mode

