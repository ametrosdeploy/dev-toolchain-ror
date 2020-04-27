FROM ruby:2.7.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs libsqlite3-dev \
    && apt-get clean autoclean \
    && apt-get autoremove -y
RUN apt-get update
RUN mkdir /app
WORKDIR /app
COPY Gemfile Gemfile.lock /app/
RUN bundle install 
COPY . /app
RUN chmod u+x bin/rails
CMD bundle exec rails s -e production -p 3000 -b '0.0.0.0'
EXPOSE 3000
