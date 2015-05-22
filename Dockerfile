FROM ruby

CMD ["echo @@@@@@@@@@@@@@@@@@@@@@@@@@@"]

CMD [""]
RUN git clone https://github.com/ivoneijr/simple-sinatra.git

CMD [""]
RUN ls -la

CMD [""]
WORKDIR "/simple-sinatra"

CMD [""]
RUN ls -la


CMD [""]
RUN bundle install

CMD [""]
RUN rackup -o 0.0.0.0

CMD ["echo @@@@@@@@@@@@@@@@@@@@@@@@@@@"]

