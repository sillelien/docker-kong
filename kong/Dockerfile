FROM debian:wheezy
COPY build.sh /build.sh
RUN chmod +x /build.sh
RUN /build.sh
COPY kong.yml /kong.yml
COPY run.sh /run.sh
RUN chmod +x /run.sh
CMD /run.sh
EXPOSE 8000 8001