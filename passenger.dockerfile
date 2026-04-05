FROM ruby:latest
COPY setup/ruby/ /
COPY setup/passenger/ /
WORKDIR /srv/http
RUN bundle install
RUN chmod +x start.sh
EXPOSE 80
CMD ["./start.sh"]
