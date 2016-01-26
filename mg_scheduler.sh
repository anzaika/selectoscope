#!/bin/bash

# docker pull anzaika/selectoscope
cd /home/anzaika/projects/selectoscope
~/bin/docker-compose -f mg_worker_production.yml build sidekiq
~/bin/docker-compose -f mg_worker_production.yml up
