FROM ruby:2.4.4
RUN apt-get update -qq && apt-get install -y nodejs
RUN mkdir /proxy_app
WORKDIR /proxy_app
COPY Gemfile /proxy_app/Gemfile
COPY Gemfile.lock /proxy_app/Gemfile.lock
RUN bundle install
COPY . /proxy_app

EXPOSE 3003

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
