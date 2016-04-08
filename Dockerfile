FROM anzaika/selectoscope_base

RUN curl --silent --location https://deb.nodesource.com/setup_5.x | sudo bash - &&\
    apt-get update -qq &&\
    apt-get install -y nodejs &&\
    npm install webpack webpack-dev-server -g

ENV DEV_USER dev_user
ENV PROD_USER prod_user
ENV GROUP runners

RUN groupadd $GROUP
RUN useradd $DEV_USER -G $GROUP -u 1000 -ms /bin/bash -U
RUN useradd $PROD_USER -G $GROUP -u 1013 -ms /bin/bash -U

# Install heavy gems for adding an extra caching layer
RUN gem install nokogiri:1.6.7.2 oj:2.15.0

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
