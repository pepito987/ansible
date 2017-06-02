FROM gliderlabs/alpine:3.4

WORKDIR /app

RUN apk --update add python py-pip openssl ca-certificates make ruby ruby-bundler ruby-dev
RUN apk --update add --virtual build-dependencies libffi-dev openssl-dev python-dev build-base wget
RUN pip install --upgrade pip

COPY requirements.txt /app/

RUN pip install -Ur requirements.txt

# Clean APK cache
RUN rm -rf /var/cache/apk/*

COPY Gemfile /app/
RUN bundle install

RUN apk del build-dependencies