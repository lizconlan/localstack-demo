FROM ruby:2.7.8

RUN apt-get update
RUN apt-get install -y python3 python3-pip
RUN pip install awscli awscli-local
RUN gem install bundler -v 2.4.22

WORKDIR /app

COPY .ruby-version Gemfile Gemfile.lock spec/* /app/
COPY lib/ /app/lib/
COPY spec/ /app/spec/

RUN bundle install

ENTRYPOINT [""]
CMD ["sleep", "infinity"]
