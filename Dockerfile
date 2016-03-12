FROM phusion/passenger-ruby22

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

ENV TIMESTAMP 13-03-2016

# Additional packages
RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y --no-install-recommends mysql-client-core-5.5 vim-nox build-essential autoconf curl git wget automake libtool mysql-client gengetopt \
  && gem update

#####################
#       PAML        #
#####################

RUN mkdir -p /usr/src/paml \
  && curl -SL "http://abacus.gene.ucl.ac.uk/software/paml4.9a.tgz" \
  | tar zxC /usr/src/paml \
  && cd /usr/src/paml/paml4.9a/src \
  && make -j"$(nproc)" \
  && mv codeml /usr/bin/ \
  && mv baseml /usr/bin/ \
  && mv basemlg /usr/bin/ \
  && mv chi2 /usr/bin/ \
  && mv evolver /usr/bin/ \
  && mv infinitesites /usr/bin/ \
  && mv mcmctree /usr/bin/ \
  && mv pamp /usr/bin/ \
  && mv yn00 /usr/bin/ \
  && rm -rf /usr/src/paml

##########################
#       DNDSTolls        #
##########################
RUN mkdir -p /usr/src/dndstools \
  && git clone https://anzaika@bitbucket.org/Davydov/dndstools.git /usr/src/dndstools/ \
  && cd /usr/src/dndstools \
  && chmod +x cdmw.py \
  && mv cdmw.py /usr/local/bin/ \
  && chmod +x mlc2csv.py \
  && mv mlc2csv.py /usr/local/bin/ \
  && rm -rf /usr/src/dndstools

#####################
#       mafft       #
#####################

RUN mkdir -p /usr/src/mafft \
  && curl -SL "http://mafft.cbrc.jp/alignment/software/mafft-7.273-with-extensions-src.tgz" \
  | tar xvzC /usr/src/mafft \
  && cd /usr/src/mafft/mafft-7.273-with-extensions/core \
  && make -j"$(nproc)" \
  && make install \
  && rm -rf /usr/src/mafft

####################
#    Muscle        #
####################
RUN mkdir -p /usr/src/muscle \
  && curl -SL "http://www.drive5.com/muscle/downloads3.8.31/muscle3.8.31_i86linux64.tar.gz" \
  | tar xvzC /usr/src/muscle \
  && cd /usr/src/muscle \
  && mv muscle3.8.31_i86linux64 /usr/local/bin/muscle \
  && rm -rf /usr/src/muscle

#####################
#      Gblocks      #
#####################

# RUN mkdir -p /usr/src/gblocks \
#   && curl -SL "http://molevol.cmima.csic.es/castresana/Gblocks/Gblocks_Linux64_0.91b.tar.Z" \
#   | tar xvzC /usr/src/gblocks \
#   && cd /usr/src/gblocks/Gblocks_0.91b \
#   && cp Gblocks /usr/local/bin \
#   && rm -rf /usr/src/gblocks
#

#####################
#      BioPerl      #
#####################

RUN apt-get install -y --no-install-recommends libexpat-dev libcgi-session-perl libclass-base-perl libgd-gd2-perl \
  && PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'install Bundle::CPAN;quit' \
  && PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'install Text::Shellwords' \
  && PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'install Bundle::LWP' \
  && PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'install Bio::SeqIO'

#####################
#      Guidance     #
#####################
RUN mkdir -p /usr/src/guidance \
  && curl -SL "http://guidance.tau.ac.il/ver2/guidance.v2.01.tar.gz" \
  | tar xvzC /usr/src/guidance/ \
  && cd /usr/src/guidance/guidance.v2.01 \
  && make -j"$(nproc)"

#####################
#    fastcodeml     #
#####################

RUN mkdir -p /usr/src/fastcodeml \
  && curl -SL "ftp://ftp.vital-it.ch/tools/FastCodeML/FastCodeML-1.1.0.tar.gz" \
  | tar zxC /usr/src/fastcodeml \
  && cd /usr/src/fastcodeml/FastCodeML-1.1.0 \
  && mv fast /usr/bin/ \
  && rm -rf /usr/src/fastcodeml

#####################
#      PhyML        #
#####################

RUN mkdir -p /usr/src/phyml \
  && cd /usr/src \
  && git clone https://github.com/stephaneguindon/phyml.git\
  && cd phyml \
  && git checkout tags/v3.2.0 \
  && libtoolize \
  && ./configure \
  && make -j"$(nproc)" \
  && mv src/phyml /usr/local/bin \
  && rm -rf /usr/src/phyml

# Activate nginx
RUN rm -f /etc/service/nginx/down

# Install heavy gems for adding an extra caching layer
RUN gem install nokogiri:1.6.7.2 oj:2.14.6

# Install bundle of gems
RUN mkdir -p /opt/bundle-cache

COPY vendor/cache /opt/bundle-cache/vendor/cache
COPY Gemfile /opt/bundle-cache/Gemfile
COPY Gemfile.lock /opt/bundle-cache/Gemfile.lock

RUN cd /opt/bundle-cache \
  && bundle install -j6

# Copy the nginx template for configuration and preserve environment variables
RUN rm /etc/nginx/sites-enabled/default

# Add the nginx site and config
ADD webapp.conf /etc/nginx/sites-enabled/webapp.conf

# # Add the rails-env configuration file
# ADD rails-env.conf /etc/nginx/main.d/rails-env.conf

RUN mkdir /home/app/webapp

RUN usermod -u 1000 app

ENV APP_HOME /home/app/webapp
WORKDIR $APP_HOME
ADD . $APP_HOME
RUN chmod go+x /home/app/webapp

# RUN mkdir -p /etc/my_init.d
# ADD deploy/start.sh /etc/my_init.d/start.sh

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
