FROM ruby:latest
COPY setup/ruby/ /
COPY setup/falcon/ /
WORKDIR /srv/http
RUN bundle install
RUN chmod +x start.sh
EXPOSE 80
CMD ["./start.sh"]
