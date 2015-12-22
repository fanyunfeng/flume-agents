#!/bin/bash

find -L /app/logs -atime +3 -a -type f -a -name '*.COMPLETED' -exec rm -rf {} \;
