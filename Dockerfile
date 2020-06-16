FROM ubuntu:18.04

RUN apt-get update &&\
  apt-get install -y lsof &&\
  rm -rf /var/lib/apt/lists/*

COPY script.sh /script.sh

CMD ["/script.sh"]
