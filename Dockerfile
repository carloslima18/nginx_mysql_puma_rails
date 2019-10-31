FROM ruby:2.4.5
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /rails_app
WORKDIR /rails_app
COPY rails_app/Gemfile /rails_app/Gemfile
# COPY entrypoint.sh /myapp/entrypoint.sh
COPY rails_app/Gemfile.lock /rails_app/Gemfile.lock
run gem install nokogiri -v '1.10.4' --source 'https://rubygems.org/' 
run gem install nio4r -v '2.5.2' --source 'https://rubygems.org/'
RUN gem install bcrypt -v '3.1.13' --source 'https://rubygems.org/'
RUN gem install websocket-driver -v '0.7.1' --source 'https://rubygems.org/'
# RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt-get install -y nodejs
RUN bundle install
COPY rails_app /rails_app

# Add a script to be executed every time the container starts.
# COPY entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["entrypoindt.sh"]
EXPOSE 3000

# Start the main process.
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]