FROM anzaika/ruby

ENV TIMESTAMP 13-03-2016

# Additional packages
RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y --no-install-recommends mysql-client-core-5.5 vim-nox build-essential autoconf curl git wget automake libtool mysql-client gengetopt \
  && gem update

#####################
#      BioPerl      #
#####################

RUN apt-get install -y --no-install-recommends libexpat-dev libcgi-session-perl libclass-base-perl libgd-gd2-perl \
  && PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'install Bundle::CPAN;quit' \
  && PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'install Text::Shellwords' \
  && PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'install Bundle::LWP' \
  && PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'install Bio::SeqIO'

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

#####################
#       mafft       #
#####################

RUN mkdir -p /usr/src/mafft \
  && curl -SL "http://mafft.cbrc.jp/alignment/software/mafft-7.123-with-extensions-src.tgz" \
  | tar xvzC /usr/src/mafft \
  && cd /usr/src/mafft/mafft-7.123-with-extensions/core \
  && make -j"$(nproc)" \
  && make install \
  && rm -rf /usr/src/mafft

#####################
#      Gblocks      #
#####################

RUN mkdir -p /usr/src/gblocks \
  && curl -SL "http://molevol.cmima.csic.es/castresana/Gblocks/Gblocks_Linux64_0.91b.tar.Z" \
  | tar xvzC /usr/src/gblocks \
  && cd /usr/src/gblocks/Gblocks_0.91b \
  && cp Gblocks /usr/local/bin \
  && rm -rf /usr/src/gblocks

# Clean up APT when done to make the image lighter.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV DEV_USER dev_user
ENV PROD_USER prod_user
ENV GROUP runners

RUN groupadd $GROUP
RUN useradd $DEV_USER -G $GROUP -u 1000 -ms /bin/bash -U
RUN useradd $PROD_USER -G $GROUP -u 1013 -ms /bin/bash -U

# Install heavy gems for adding an extra caching layer
RUN gem install nokogiri:1.6.7.2 oj:2.14.6

RUN mkdir -p /opt/bundle
RUN mkdir -p /opt/bundle-cache
RUN mkdir -p /opt/app

COPY vendor/cache /opt/bundle-cache/vendor/cache
COPY Gemfile /opt/bundle-cache/Gemfile
COPY Gemfile.lock /opt/bundle-cache/Gemfile.lock

RUN cd /opt/bundle-cache && bundle install -j6

ENV APP_HOME /opt/app
WORKDIR $APP_HOME
ADD . $APP_HOME

RUN chown -R $PROD_USER:$GROUP /opt \
  && chmod g+rwx -R /opt \
  && chown -R $PROD_USER:$GROUP /usr/local/lib/ruby \
  && chmod g+rwx -R /usr/local/lib/ruby \
  && chown -R $PROD_USER:$GROUP /usr/local/bundle \
  && chmod g+rwx -R /usr/local/bundle

USER $PROD_USER
