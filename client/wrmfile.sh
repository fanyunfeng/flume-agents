#!/bin/bash


/bin/find /e/logs -atime +7 -a -type f -a -name *.COMPLETED -exec rm -rf {} \;
/bin/find /f/logs -atime +7 -a -type f -a -name *.COMPLETED -exec rm -rf {} \;

