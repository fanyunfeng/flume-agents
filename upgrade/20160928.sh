#!/bin/bash

sc stop hc.flume

scp admin@192.168.119.94:/share/install/opt/apache-flume-1.6.0-bin/lib/flume-ng-core-1.6.0.jar /c/opt/apache-flume-1.6.0-bin/lib

scp admin@192.168.119.94:/share/install/opt/apache-flume-1.6.0-bin/lib/hcse-flume-tools-1.0-SNAPSHOT.jar /c/opt/apache-flume-1.6.0-bin/lib


sc start hc.flume
