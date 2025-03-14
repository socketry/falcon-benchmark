FROM ruby:latest
COPY setup/ruby/ /
COPY setup/falcon/ /
WORKDIR /srv/http
RUN bundle install
EXPOSE 80
CMD ["falcon", "serve", "--count", "8", "--bind", "http://0.0.0.0:80"]
