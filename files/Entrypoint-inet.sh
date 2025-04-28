#!/bin/bash
. /server_parameters.sh
cd "$volume_location"

# Copy over server files, should not interfere with persistent files from volume
cp --recursive --no-clobber "$server_files_path" ./
cd $(ls -d */)

read -p "Do you want to update who has operator powers? [THIS OVERWRITES EXISTING OPS WITH server_parameters.sh DEFINED USERS] (y/n)" yn

if [ $yn == "y" ]; then
    echo "You entered 'y'... will update ops.json before starting server..."
    echo '[' > ops.json
    for username in ${ops[@]}; do
        curl https://playerdb.co/api/player/minecraft/$username > $username.json
        id=$(jq .data.player.id $username.json)
        echo '{"uuid": '$id',"name": "'$username'","level": 4,"bypassesPlayerLimit": false},' >> ops.json
        rm $username.json
    done
    # Remove final trailing ','
    seded=$(sed '$ s/.$//' ops.json)
    echo $seded > ops.json
    echo ']' >> ops.json

    ./run.sh
else
    echo "You did not enter 'y'... will continue without updating ops.json..."
    ./run.sh 
fi