FROM ruby:3.4
COPY setup/ruby/ /
COPY setup/unicorn/ /
WORKDIR /srv/http
RUN bundle install
RUN chmod +x start.sh
EXPOSE 80
CMD ["./start.sh"]
