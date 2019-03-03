FROM ruby:2.4.4
RUN apt-get update -qq && apt-get install -y nodejs
RUN mkdir /main_direct_app
WORKDIR /main_direct_app
COPY Gemfile /main_direct_app/Gemfile
COPY Gemfile.lock /main_direct_app/Gemfile.lock
RUN bundle install
COPY . /main_direct_app

EXPOSE 3001

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
