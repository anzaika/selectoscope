#!/bin/bash

cd /home/anzaika/projects/selectoscope
~/bin/docker-compose -f compose_production_worker.yml build sidekiq
~/bin/docker-compose -f compose_production_worker.yml up
