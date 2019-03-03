FROM ruby:2.4.4
RUN apt-get update -qq && apt-get install -y nodejs
RUN mkdir /main_via_proxy_app_two
WORKDIR /main_via_proxy_app_two
COPY Gemfile /main_via_proxy_app_two/Gemfile
COPY Gemfile.lock /main_via_proxy_app_two/Gemfile.lock
RUN bundle install
COPY . /main_via_proxy_app_two

EXPOSE 3006

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
