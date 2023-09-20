#!/bin/bash
virsh start $1
virt-manager --connect qemu:///session --show-domain-console $1
