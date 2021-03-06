**Warning**: This project is not currently actively developed. It is unlikely that it is usable in the near future.

[![Project Status: Abandoned – Initial development has started, but there has not yet been a stable, usable release; the project has been abandoned and the author(s) do not intend on continuing development.](https://www.repostatus.org/badges/latest/abandoned.svg)](https://www.repostatus.org/#abandoned)


Selectoscope
================

Selectoscope is a web application which combines a number of popular tools used to infer positive selection in an easy to use pipeline. A set of homologous DNA sequences to be analyzed and evaluated are submitted to the server by uploading protein-coding gene sequences in the FASTA format. The sequences are aligned and a phylogenetic tree is constructed. The codeml procedure from the PAML package is used first to adjust branch lengths and to find a starting point for the likelihood maximization, then FastCodeML is executed. Upon completion, branches and positions under positive selection are visualized simultaneously on the tree and alignment viewers. Run logs are accessible through the web interface. Selectoscope is based on the Docker virtualization technology. This makes the application easy to install with a negligible performance overhead. The application is highly scalable and can be used on a single PC or on a large high performance clusters.

#Installation

Make sure you have [Docker](https://docs.docker.com/engine/installation/) and [docker-compose](https://docs.docker.com/compose/install/) installed on your system

```
mkdir ~/projects/selectoscope
git clone https://github.com/anzaika/selectoscope.git ~/projects/selectoscope
cd ~/projects/selectoscope
docker-compose -f compose_development.yml run web rake db:setup
docker-compose -f compose_development.yml up
```

This this sequence should be run only once, at the time of installation.
Afterwards you can relaunch the server with the last command only.

This sequence of commands will start a web-server on port 3009. So after this you can open your browser and navigate to
[localhost:3009](http://localhost:3009).

Default user is admin@example.com with password 'password'.


