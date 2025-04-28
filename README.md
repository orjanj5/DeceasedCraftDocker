# PragmaticMCServerDocker

DeceasedCraft Server run in a container built from the ground up.

All commands and contents of server_parameters.sh are based on using DeceasedCraft's server pack and my user as OP.

## Requirements
- Docker (linux) / Docker Desktop (windows)
- A link to the download of a minecraft server pack (zip)
- Make sure the Entrypoint.sh file has LF new-lines as it is required by the Alpine OS. (my vsCode sets CRLF automatically)

## Installation
Clone Repository
```bash
git clone https://github.com/orjanj5/DeceasedCraftDocker.git
```

## Usage

### Prepare server_parameters.sh
1. Enter download URL to the server pack in the 'download_url' parameter
2. (optional) redefine staging_location
3. (optional) redefine volume_location  
4. (optional) define which users get OP by adding ops[X]="<username>" lines, where X=0,1,2... 

### Build
```bash
# Build Standalone
docker build -f Dockerfile.inet --tag dcraft-inet .
```

### Run
Run the image (NB! volume must match volume_location in server_parameters)
```bash
docker run --detach --name dcraft-inet-container --user minecraft:minecraft --volume G:\Minecraft\dcraft_persistent:/opt/server -p 55565:25565 dcraft-inet
```

(Optional: inspect the progress/server log)
```bash
docker attach dcraft-inet-container
```
