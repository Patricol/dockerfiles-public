FROM node:alpine

RUN apk -U upgrade \
 && apk add --no-cache -t build-dependencies \
    git \
    curl-dev \
    wget \
    ruby-dev \
    build-base \
    zlib-dev \
 && apk add --no-cache \
    tzdata \
    ruby \
    ruby-io-console \
    ruby-json \
    ruby-bigdecimal \
 && git clone https://github.com/standardnotes/web.git /standardnotes \
 && gem install -N rails --version "$RAILS_VERSION" \
 && echo 'gem: --no-document' >> ~/.gemrc \
 && cp ~/.gemrc /etc/gemrc \
 && chmod a+r /etc/gemrc \
 && rm -rf ~/.gem \
 && cd /standardnotes \
 && echo "gem 'etc'" >> ./Gemfile \
 #patch for an issue they currently have?
 && bundle config --global silence_root_warning 1 \
 && bundle install --system \
 && npm install \
 && npm install -g bower grunt \
 && bundle exec rake bower:install \
 && npm run build \
 && git submodule update --init --force --remote \
 && apk del build-dependencies \
 && rm -rf /tmp/* /var/cache/apk/* /root/.gnupg/ /root/.cache/ /standardnotes/.git/

ENV EXTENSIONS_MANAGER_LOCATION=extensions/extensions-manager/dist/index.html
ENV BATCH_MANAGER_LOCATION=extensions/batch-manager/dist/index.min.html

ENV SF_DEFAULT_SERVER=https://sync.standardnotes.org

EXPOSE 3000

WORKDIR /standardnotes

CMD bundle exec rails s -b 0.0.0.0
