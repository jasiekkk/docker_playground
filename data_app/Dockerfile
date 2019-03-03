FROM ruby:2.4.4
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /data_app
WORKDIR /data_app
COPY Gemfile /data_app/Gemfile
COPY Gemfile.lock /data_app/Gemfile.lock
RUN bundle install
COPY . /data_app

EXPOSE 3004

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
