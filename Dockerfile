FROM anzaika/ruby

#####################
#       PAML        #
#####################

RUN mkdir -p /usr/src/paml \
  && curl -SL "http://abacus.gene.ucl.ac.uk/software/paml4.8a.tgz" \
  | tar zxC /usr/src/paml \
  && cd /usr/src/paml/paml4.8/src \
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
  && curl -SL "http://mafft.cbrc.jp/alignment/software/mafft-7.245-with-extensions-src.tgz" \
  | tar xvzC /usr/src/mafft \
  && cd /usr/src/mafft/mafft-7.245-with-extensions/core \
  && make -j"$(nproc)" \
  && make install \
  && rm -rf /usr/src/mafft

# #####################
# #      Pagan        #
# #####################
#
# RUN mkdir -p /usr/src/pagan \
#   && curl -SL "http://wasabiapp.org/download/pagan/pagan.linux64.20150723.tgz" \
#   | tar xvzC /usr/src/pagan \
#   && cd /usr/src/pagan/pagan/bin \
#   && mv pagan /usr/local/bin \
#   && mv bppancestor /usr/local/bin \
#   && mv bppdist /usr/local/bin \
#   && mv bppphysamp /usr/local/bin \
#   && mv exonerate /usr/local/bin \
#   && mv raxml /usr/local/bin \
#   && rm -rf /usr/src/pagan

#####################
#     Muscle        #
#####################
RUN mkdir -p /usr/src/muscle \
  && curl -SL "http://www.drive5.com/muscle/downloads3.8.31/muscle3.8.31_i86linux64.tar.gz" \
  | tar xvzC /usr/src/muscle \
  && cd /usr/src/muscle \
  && mv muscle3.8.31_i86linux64 /usr/local/bin/muscle \
  && rm -rf /usr/src/muscle

#####################
#      Gblocks      #
#####################

RUN mkdir -p /usr/src/gblocks \
  && curl -SL "http://molevol.cmima.csic.es/castresana/Gblocks/Gblocks_Linux64_0.91b.tar.Z" \
  | tar xvzC /usr/src/gblocks \
  && cd /usr/src/gblocks/Gblocks_0.91b \
  && cp Gblocks /usr/local/bin \
  && rm -rf /usr/src/gblocks

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
  && libtoolize \
  && ./configure \
  && make \
  && mv src/phyml /usr/local/bin \
  && rm -rf /usr/src/phyml

ENV DEV_USER dev_user
ENV PROD_USER prod_user
ENV GROUP runners

RUN groupadd $GROUP
RUN useradd $DEV_USER -G $GROUP -u 1000 -ms /bin/bash -U
RUN useradd $PROD_USER -G $GROUP -u 1013 -ms /bin/bash -U

RUN mkdir -p /opt/bundle
RUN mkdir -p /opt/bundle-cache
RUN mkdir -p /opt/app

COPY vendor/cache /opt/bundle-cache/vendor/cache
COPY Gemfile /opt/bundle-cache/Gemfile
COPY Gemfile.lock /opt/bundle-cache/Gemfile.lock

RUN cd /opt/bundle-cache \
  && bundle install -j6 --path /opt/bundle

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
