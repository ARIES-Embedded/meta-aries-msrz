#!/bin/sh
### BEGIN INIT INFO
# Provides:          usbeth
# Required-Start:
# Required-Stop:
# Default-Start:
# Default-Stop:      0 6
# Short-Description: Start Ethernet gadget over USB-A.
# Description:
### END INIT INFO

. /etc/default/rcS

PATH=/sbin:/bin:/usr/sbin:/usr/bin

case "$1" in
	start|"")
		/usr/sbin/usb-gadget-eth.sh 11c60000.usb
		;;
	stop)
		/usr/sbin/usb-gadget-stop.sh 11c60000.usb
		;;
	*)
		echo "Usage: $0 {start|stop}" >&2
		exit 1
		;;
esac

exit 0
