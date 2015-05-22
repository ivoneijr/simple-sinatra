FROM ruby

CMD ["echo @@@@@@@@@@@@@@@@@@@@@@@@@@@"]

CMD ["echo download project from git"]
RUN git clone https://github.com/ivoneijr/simple-sinatra.git

CMD ["echo define /simple sinatra workdir"]
WORKDIR "/simple-sinatra"

CMD ["echo simple-sinatra list files"]
RUN ls -la

RUN bundle install




