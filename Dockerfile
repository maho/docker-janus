FROM ubuntu:20.04


RUN apt-get update && apt-get install -y motion &&  rm -rf /var/lib/apt/lists/*

COPY conf/motion.conf /etc/motion.conf

CMD motion -c /etc/motion.conf
