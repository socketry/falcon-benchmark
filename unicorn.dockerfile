FROM ruby:latest
COPY setup/ruby/ /
COPY setup/unicorn/ /
WORKDIR /srv/http
RUN bundle install
EXPOSE 80
CMD ["unicorn", "-E", "production", "-c", "config.rb"]
