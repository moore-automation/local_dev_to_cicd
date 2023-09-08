#!/bin/bash
  
# turn on bash's job control
set -m
  
# Start the primary process and put it in the background
/assets/wrapper &
  
# Start the helper process
/gitlab-entrypoint.sh
  
# now we bring the primary process back into the foreground
# and leave it there
fg %1