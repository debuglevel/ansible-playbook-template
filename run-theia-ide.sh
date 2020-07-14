#!/bin/bash
USER=1002
PORT=1234
echo "Starting theia as docker container..."
sudo docker run -d --user $USER --name theia --init -p $PORT:3000 -v "${PWD}:/home/project:cached" theiaide/theia:latest