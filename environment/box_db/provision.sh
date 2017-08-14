#!/usr/bin/env bash

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
sudo apt-get update
sudo apt-get install -y mongodb-org

sudo rm /lib/systemd/system/mongod.service
sudo cp /home/ubuntu/app/environment/box_db/templates/mongod.service /lib/systemd/system/mongod.service

sudo rm /etc/mongod.conf
sudo cp /home/ubuntu/app/environment/box_db/templates/mongod.conf /etc/mongod.conf

sudo systemctl daemon-reload
sudo systemctl start mongod
sudo systemctl enable mongod


export LC_ALL=C