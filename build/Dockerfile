FROM phusion/passenger-ruby23

# set rails env vars
# ENV RAILS_ENV production
ENV RAILS_ENV development
ENV BUNDLE_PATH /bundle

# set the app directory var
ENV APP_HOME /home/app
WORKDIR $APP_HOME

RUN apt-get update -qq

# Update apt
RUN apt-get update -y

# Install apt dependencies
RUN apt-get install -y --no-install-recommends \
  build-essential \
  curl libssl-dev \
  git \
  unzip \
  zlib1g-dev \
  libxslt-dev \
  postgresql \
  libpq-dev

# Separate task from `ADD . .` as it will be
# Skipped if gemfile.lock hasn't changed
COPY Gemfile* ./

# Install gems to /bundle
RUN bundle install

ADD . .

# Precompile assets - only want to do for production
# RUN bundle exec rake assets:precompile

EXPOSE 3000

CMD ["/sbin/my_init"]

