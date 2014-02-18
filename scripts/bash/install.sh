#!/bin/bash
rm /usr/share/tess-1.0/* -rf
cp /home/toccig/target/universal/stage/* /usr/share/tess-1.0/ -rf
chmod 750 /usr/share/tess-1.0/bin/tess