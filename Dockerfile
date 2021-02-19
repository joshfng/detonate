FROM ruby:2.7.2-alpine

ENV APP_PATH /var/app
ENV BUNDLE_VERSION 2.2.10
ENV BUNDLE_PATH /usr/local/bundle/gems
ENV TMP_PATH /tmp/
ENV RAILS_LOG_TO_STDOUT true
ENV RAILS_PORT 3000

# install dependencies for application
RUN apk -U add --no-cache \
  build-base \
  git \
  postgresql-dev \
  postgresql-client \
  libxml2-dev \
  libxslt-dev \
  nodejs \
  yarn \
  imagemagick \
  tzdata \
  less \
  && rm -rf /var/cache/apk/* \
  && mkdir -p $APP_PATH

RUN gem install bundler --version "$BUNDLE_VERSION" \
  && rm -rf $GEM_HOME/cache/*

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

COPY Gemfile Gemfile.lock ./
RUN bundle install -j $(nproc) --retry=4

COPY . ./var/app/

RUN bundle exec rails assets:precompile

# navigate to app directory
WORKDIR $APP_PATH

EXPOSE $RAILS_PORT

ENTRYPOINT [ "bundle", "exec" ]
