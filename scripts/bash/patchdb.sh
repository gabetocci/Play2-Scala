#!/bin/bash
cp /home/toccig/scripts/sql/patch.sql /opt/
sudo -u postgres psql -d tesp -a -f /opt/patch.sql