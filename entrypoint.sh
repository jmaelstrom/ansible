#!/bin/bash

if [[ ! -d /tmp/hostssh ]]; then
    echo "Must mount the host SSH directory at /tmp/hostssh"
    exit 1
fi

# Generate temporary SSH key to allow access to the host machine.
mkdir -p /root/.ssh
ssh-keygen -f /root/.ssh/id_rsa -P ""

OWNER=$(stat -c %u /tmp/hostssh/authorized_keys)

cp /tmp/hostssh/authorized_keys /tmp/hostssh/authorized_keys.bak
cat /root/.ssh/id_rsa.pub >>/tmp/hostssh/authorized_keys
chown $OWNER:$OWNER /tmp/hostssh/authorized_keys

CMD=$1
shift

eval $CMD "$@"

mv /tmp/hostssh/authorized_keys.bak /tmp/hostssh/authorized_keys
chown $OWNER:$OWNER /tmp/hostssh/authorized_keys
