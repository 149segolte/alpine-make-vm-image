#!/bin/sh

_step_counter=0
step() {
	_step_counter=$(( _step_counter + 1 ))
	printf '\n\033[1;36m%d) %s\033[0m\n' $_step_counter "$@" >&2  # bold cyan
}

uname -a

step 'Set up timezone'
setup-timezone -z America/New_York

step 'Set up cloud-init'
setup-cloud-init

step 'Add UsePAM yes to /etc/ssh/sshd_config'
echo 'UsePAM yes' > /etc/ssh/sshd_config.d/00-usepam.conf

step 'Enable services'
rc-update add chronyd default
rc-update add qemu-guest-agent default
