FROM ruby:3.0.2

RUN mkdir /usr/src/app

# Create a dedicated user for running the application
RUN adduser --no-create-home www

# Set the user for RUN, CMD or ENTRYPOINT calls from now on
# Note that this doesn't apply to COPY or ADD, which use a --chown argument instead
USER www

ADD server /usr/src/app/

WORKDIR /usr/src/app/

CMD ["ruby", "http_server.rb"]