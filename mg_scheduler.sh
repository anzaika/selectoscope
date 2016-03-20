#!/bin/bash

docker pull anzaika/selectoscope
cd /home/anzaika/projects/selectoscope
~/bin/docker-compose -f compose_production_worker.yml up
