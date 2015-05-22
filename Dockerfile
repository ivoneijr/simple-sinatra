FROM ruby
CMD ["echo @@@@@@@@@@@@@@@@@@@@@@@@@@@"]
RUN git clone https://github.com/ivoneijr/simple-sinatra.git
RUN ls -la
RUN cd /simple-sinatra
RUN bundle install
RUN rackup -o 0.0.0.0
CMD ["echo @@@@@@@@@@@@@@@@@@@@@@@@@@@"]

