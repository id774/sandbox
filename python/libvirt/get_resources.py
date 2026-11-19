#!/usr/bin/env python
# get_resources.py: List libvirt domains with CPU and memory limits
#
# Description:
# List running and defined libvirt domains with their CPU and memory limits.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 get_resources.py
#
# Requirements:
# - Python 3
# - libvirt with its Python binding and access to qemu:///system
#

import libvirt

c = libvirt.open('qemu:///system')

ids = c.listDomainsID()
for id in ids:
    vm = c.lookupByID(id)
    print("%s (id:%s)" % (vm.name(), vm.ID()))
    print("max vcpus : %s" % vm.maxVcpus())
    maxmem = vm.maxMemory()
    print(maxmem)

defined_ids = c.listDefinedDomains()
for id in defined_ids:
    vm = c.lookupByName(id)
    print("%s (not running)" % vm.name())
