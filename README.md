# DeceasedCraftDocker

DeceasedCraft Server run in a container built from the ground up.
    It does not have centralized parameters yet

## Requirements
- Docker (linux) / Docker Desktop (winodws)
- A minecraft server pack (zip or equivalent)
- Make sure the Entrypoint.sh file has LF new-lines as it is required by the Alpine OS. (my vsCode sets CRLF automatically)

## Installation
Clone Repository
```bash
git clone https://github.com/orjanj5/DeceasedCraftDocker.git
```

## Usage

### Standalone
The files folder requires the following files
- Entrypoint-standalone.sh (included)
- ops.json (included) (may be empty with only [])
- Server-Files.zip

#### Build
```bash
# Build Standalone
docker build --tag alpine-deceasedcraft-standalone -f Dockerfile.standalone .
```

#### Run
Run the image
```bash
docker run --detach --name DeceasedCraft_Server_standalone -p 127.0.0.1:55565:25565/tcp alpine-deceasedcraft-standalone
```

(Optional: inspect the progress/server log)
```bash
docker attach DeceasedCraft_Server_standalone
```

(Optional: Access the server outside the java server instance)
```bash
docker exec -it DeceasedCraft_Server_standalone /bin/bash
```

### Persistent world
To achieve a persistent world, the world files (or server files in this case) must be stored in a persistent storage.
This is solved using a mounted volume from the host into the container to run from.

#### Build
1. Create a folder to house the server files
2. Download the server pack and unzip it in the folder from step 1.
3. Populate the folder with eula.txt containing "eula=true"
4. Populate the folder with an ops.json containing the list of users who are to receive OP
5. Build the image using the Dockerfile.persistent
```bash
#Build persistent
docker build --tag alpine-deceasedcraft-persistent -f Dockerfile.persistent .
```

#### Run
Running the image with the correct permissions is achieved here using a docker compose file.
Using the compose.yaml in the repository, alter the folder defined in the volumes to match the folder created in step 1. above.
Start the container using docker compose
```bash
docker compose up -d
```

(Optional: inspect the progress/server log)
```bash
docker attach deceasedcraftdocker-DeceasedCraft_Server_persistent-1
```

(Optional: Access the server outside the java server instance)
```bash
docker exec -it deceasedcraftdocker-DeceasedCraft_Server_persistent-1 /bin/bash
```
