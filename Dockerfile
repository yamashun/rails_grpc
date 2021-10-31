FROM ruby:3.0.2-buster

ENV LANG=C.UTF-8

WORKDIR /var/app/api

RUN groupadd -g 2000 app
RUN adduser --disabled-login --shell /sbin/nologin --gid 2000 --uid 2000 app
RUN chown app:app /var/app/api

USER 2000

ARG BUNDLE_GITHUB__COM
COPY Gemfile Gemfile.lock ./
RUN BUNDLER_VERSION=`grep -A1 'BUNDLED WITH' Gemfile.lock | tail -n 1 | sed -e 's/ //g'` \
    && gem install bundler -v ${BUNDLER_VERSION} \
    && bundle config build.nokogiri --use-system-libraries \
    && bundle config set jobs $(nproc) \
    && bundle _${BUNDLER_VERSION}_ install

CMD ["sh", "-c", "bundle install && rm -f tmp/pids/server.pid && rails s -p 3000 -b '0.0.0.0'"]