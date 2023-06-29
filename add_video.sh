#!/bin/bash

set -e
# CREATE_DISPLAY=4
# # Use CREATE_DISPLAY env variable or default to 4 
# CREATE_ID=${CREATE_DISPLAY:-4}

# echo "CREATE_DISPLAY: ${CREATE_DISPLAY} | CREATE_ID: ${CREATE_ID}"

CREATE_ID=0

# Let Xvfb create the display
Xvfb :${CREATE_ID} &

echo "trying to create virtual display named ${CREATE_ID}"

display_ready=0
tries=0

# Wait for the display to be ready
while [ $display_ready = 1 ] || [ $tries -lt 10 ]
do
    if xdpyinfo -display :${CREATE_ID} >& /dev/null ; then break
    else echo "Virutal display not ready yet (try $tries)" && sleep 1 ; fi
    tries=`expr $tries + 1`
done

if xdpyinfo -display :${CREATE_ID} >& /dev/null ; then echo "Display exists"
else echo "Display invalid, too many tries" && exit -1 ; fi

# Export DISPLAY env variable to use it in following commands
export DISPLAY=:${CREATE_ID}
