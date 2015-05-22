FROM ruby

CMD ["echo @@@@@@@@@@@@@@@@@@@@@@@@@@@"]

CMD ["echo 1"]
RUN git clone https://github.com/ivoneijr/simple-sinatra.git

CMD ["echo 2"]
RUN ls -la

CMD ["echo 3"]
RUN cd /simple-sinatra

CMD ["echo 4"]
RUN ls -la

CMD ["echo 5"]
RUN sudo bundle install

CMD ["echo 6"]
RUN rackup -o 0.0.0.0

CMD ["echo @@@@@@@@@@@@@@@@@@@@@@@@@@@"]

