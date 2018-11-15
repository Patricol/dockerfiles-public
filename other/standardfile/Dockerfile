FROM node:alpine

RUN mkdir -p /usr/local/etc \
 && echo 'install: --no-document' >> /usr/local/etc/gemrc \
 && echo 'update: --no-document' >> /usr/local/etc/gemrc \
 && apk -U upgrade \
 && apk add --no-cache -t build-dependencies \
    git \
    curl-dev \
    wget \
    ruby-dev \
    build-base \
    zlib-dev \
    mariadb-dev \
 && apk add --no-cache \
    tzdata \
    ruby \
    ruby-io-console \
    ruby-json \
    ruby-bigdecimal \
    zlib \
    #mariadb-client-libs \
 && git clone https://github.com/standardfile/ruby-server.git /standardfile \
 && gem install -N rails --version "$RAILS_VERSION" \
 && echo 'gem: --no-document' >> ~/.gemrc \
 && cp ~/.gemrc /etc/gemrc \
 && chmod a+r /etc/gemrc \
 && npm install -g bower \
 && rm -rf ~/.gem \
 && cd /standardfile \
 && gem install bigdecimal \
# && echo "gem 'etc'" >> ./Gemfile \
 #patch for an issue they currently have?
 && bundle config --global silence_root_warning 1 \
 && bundle install --system \
 && bower install --allow-root \
 && apk del build-dependencies \
 && bundle exec rake assets:precompile \
 && rm -rf /tmp/* /var/cache/apk/* /root/.gnupg/ /root/.cache/ /standardfile/.git/

ENV RAILS_ENV=production
ENV DB_HOST=localhost
ENV DB_PORT=3306

EXPOSE 3306

WORKDIR /standardnotes
COPY /docker /docker

ENTRYPOINT [ "/docker/entrypoint" ]
CMD [ "start" ]