FROM ruby:2.4.4
RUN apt-get update -qq && apt-get install -y nodejs
RUN mkdir /main_via_proxy_app
WORKDIR /main_via_proxy_app
COPY Gemfile /main_via_proxy_app/Gemfile
COPY Gemfile.lock /main_via_proxy_app/Gemfile.lock
RUN bundle install
COPY . /main_via_proxy_app

EXPOSE 3002

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
