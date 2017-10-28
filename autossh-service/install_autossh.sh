#!/bin/bash
program="autossh"
program_path="/home/vesel"
#sudo adduser --system --group --disabled-password autossh


sudo apt -y  update
sudo apt -y  upgrade
sudo apt -y  install autossh

# stop service if exists
# sudo systemctl stop autossh.service
sudo systemctl stop autossh.service
sleep 1

sudo cp  ./warehouse_rsa.pub /home/vesel/.ssh
sudo cp  ./warehouse_rsa     /home/vesel/.ssh
sudo cp  ./config            /home/vesel/.ssh
sudo chmod 600 /home/vesel/.ssh/warehouse_rsa.pub
sudo chmod 600 /home/vesel/.ssh/warehouse_rsa
sudo chown vesel:vesel /home/vesel/.ssh/warehouse_rsa
sudo chown vesel:vesel /home/vesel/.ssh/warehouse_rsa.pub

# copy templates
sudo cp ./autossh.service /lib/systemd/system/
sudo ln -s /lib/systemd/system/autossh.service \
      /etc/systemd/system/autossh.service
sudo cp ./autossh /etc/default/autossh

sleep 1
# enable and start service
sudo systemctl daemon-reload
sudo systemctl enable autossh.service
sudo systemctl start autossh.service