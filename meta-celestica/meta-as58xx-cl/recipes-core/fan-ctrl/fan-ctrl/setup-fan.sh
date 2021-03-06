#!/bin/bash
#
# Copyright 2018-present Celestica. All Rights Reserved.
#
# This program file is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the
# Free Software Foundation; version 2 of the License.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
# for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program in a file named COPYING; if not, write to the
# Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor,
# Boston, MA 02110-1301 USA
#

### BEGIN INIT INFO
# Provides:          setup-fan
# Required-Start:    board-id
# Required-Stop:
# Default-Start:     S
# Default-Stop:
# Short-Description: Set fan speed
### END INIT INFO
. /usr/local/bin/openbmc-utils.sh

echo "Setup fan speed... "
/usr/local/bin/set_fan_speed.sh 50
cp /etc/pid_config.ini /mnt/data/
cp /etc/pid_config_v2.ini /mnt/data/
brd_type=$(board_type)
if [ "$brd_type" = "Fishbone48" ]; then
    echo "Run FSC daemon fand_v2"
    /usr/local/bin/fand_v2
elif [ "$brd_type" = "Fishbone32" ]; then
    echo "Run FSC daemon fand32_v2"
    /usr/local/bin/fand32_v2
elif [ "$brd_type" = "Phalanx" ]; then
    echo "Run FSC daemon fand_phalanx"
    cp /etc/pid_config_v2_phalanx.ini /mnt/data/pid_config_v2.ini -rf
    /usr/local/bin/fand_phalanx
else
    echo "Run default FSC daemon fand_v2"
    /usr/local/bin/fand_v2
fi
echo "done."
