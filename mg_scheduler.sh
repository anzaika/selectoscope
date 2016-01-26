#!/bin/bash

# docker pull anzaika/selectoscope
~/bin/docker-compose -f mg_worker_production.yml build sidekiq
cd /home/anzaika/projects/selectoscope
~/bin/docker-compose -f mg_worker_production.yml up
