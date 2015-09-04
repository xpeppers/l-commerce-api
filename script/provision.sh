#!/bin/sh -e

[ -z $HOST ] && HOST='192.168.33.100'
[ -z $HOST_USER ] && HOST_USER='vagrant'
[ -z $RUN_LIST ] && RUN_LIST='linking-commerce-api::default'
[ -z $KNIFE_OPTS ] && KNIFE_OPTS=''

berks vendor .berks-cookbooks

knife zero bootstrap $HOST \
  --node-name $HOST \
  --no-host-key-verify \
  --config knife.rb \
  --ssh-user $HOST_USER \
  --run-list $RUN_LIST \
  --sudo \
  $KNIFE_OPTS
