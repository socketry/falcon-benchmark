FROM ruby:latest
COPY setup/ruby/ /
COPY setup/falcon/ /
WORKDIR /srv/http
RUN bundle install
EXPOSE 80
CMD ["bundle", "exec", "falcon", "host", "falcon.rb"]
