#!/bin/bash

scp admin@192.168.119.94:/share/install/opt/apache-flume-1.6.0-bin/lib/flume-ng-core-1.6.0.jar /opt/apache-flume-1.6.0-bin/lib
scp admin@192.168.119.94:/share/install/opt/apache-flume-1.6.0-bin/lib/hcse-flume-tools-1.0-SNAPSHOT.jar /opt/apache-flume-1.6.0-bin/lib

/app/daemontools/bin/svc -k /app/service/flume.client
