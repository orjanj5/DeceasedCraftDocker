#!/bin/bash
. /server_parameters.sh

cd "$volume_location"

# Copy over server files, should not interfere with persistent files from volume
cp --recursive --no-clobber "$server_files_path/*" ./

# IF folder is empty
if [ -z "$( ls -A . )" ]; then
    # populate ops.json
    echo '[' > ops.json
    for username in ${ops[@]}; do
        curl https://playerdb.co/api/player/minecraft/$username > $username.json
        id=$(jq .data.player.id $username.json)
        echo '{"uuid":"$id", "name":"$username", "level":4},' >> ops.json
    done
    truncate -s-1 ops.json
    echo ']' >> ops.json

    # run run.sh
    ./run.sh
    
# IF folder is populated 
else
    # run run.sh
    ./run.sh
fi


