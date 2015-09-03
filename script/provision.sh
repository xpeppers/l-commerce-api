#!/bin/sh -e

berks vendor .berks-cookbooks
# knife zero bootstrap $HOST -c ./knife.rb -x $HOST_USER -r $RUN_LIST -N $HOST --sudo $OPTIONS

# knife zero bootstrap 192.168.33.100 -c ./knife.rb -x vagrant -r "linking-commerce-api::default" -N 192.168.33.100 --sudo

knife zero bootstrap 192.168.33.100 \
  --node-name 192.168.33.100 \
  --no-host-key-verify \
  --config knife.rb \
  --ssh-user vagrant \
  --run-list "linking-commerce-api::default" \
  --sudo

