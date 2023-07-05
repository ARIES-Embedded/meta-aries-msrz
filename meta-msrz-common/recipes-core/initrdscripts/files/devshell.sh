#!/bin/sh

devshell_enabled() {
	return 1
}

devshell_run() {
	PATH=/sbin:/bin:/usr/sbin:/usr/bin
	exec sh
}
