FROM ruby

RUN mkdir /centralbank
WORKDIR /centralbank
COPY . /centralbank/
RUN bundle install --quiet
EXPOSE 9292 
CMD [ "rackup", "--host", "0.0.0.0", "-p", "9292"]

