FROM ruby:3.4.3

ENV APP_PATH /var/app
ENV BUNDLE_VERSION 2.6.2
ENV BUNDLE_PATH /usr/local/bundle/gems
ENV TMP_PATH /tmp/
ENV RAILS_LOG_TO_STDOUT true
ENV RAILS_PORT 3000

# install dependencies for application
RUN apt-get update && apt-get install -y --no-install-recommends \
  bash \
  build-essential \
  curl \
  git \
  imagemagick \
  libgmp-dev \
  libjemalloc2 \
  libpq-dev \
  libssl-dev \
  libvips \
  libyaml-dev \
  nodejs \
  pkg-config \
  postgresql \
  rustc \
  sqlite3 \
  tzdata \
  yarn \
  zlib1g-dev && \
  apt-get autoclean && \
  apt-get autoremove && \
  mkdir -p $APP_PATH

RUN gem install bundler --version "$BUNDLE_VERSION" \
  && rm -rf $GEM_HOME/cache/*

COPY ./docker/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

COPY Gemfile Gemfile.lock ./
RUN bundle install -j $(nproc) --retry=4

COPY . ./var/app/

RUN bundle exec rails assets:precompile

# navigate to app directory
WORKDIR $APP_PATH

EXPOSE $RAILS_PORT

ENTRYPOINT [ "bundle", "exec" ]
