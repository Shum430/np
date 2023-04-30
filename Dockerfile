FROM ubuntu:20.04

RUN apt-get update && apt-get install -y curl

COPY webserver_check.sh /webserver_check.sh
RUN chmod +x /webserver_check.sh

CMD ["./webserver_check.sh"]
