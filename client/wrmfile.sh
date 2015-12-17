#!/bin/bash


find /e/logs -atime +7 -a -type f -a -name *.COMPLETED -exec rm -rf {} \;
find /f/logs -atime +7 -a -type f -a -name *.COMPLETED -exec rm -rf {} \;
