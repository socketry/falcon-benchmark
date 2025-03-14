FROM ruby:latest
COPY setup/ruby/ /
COPY setup/puma/ /
WORKDIR /srv/http
RUN bundle install
EXPOSE 80
CMD ["puma", "-w", "8", "--bind", "tcp://0.0.0.0:80"]
