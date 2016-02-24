FROM gliderlabs/alpine
RUN apk add --no-cache py-pip ca-certificates bash
RUN wget -O- "http://s3.amazonaws.com/babl/babl-server_linux_amd64.gz" | gunzip > /bin/babl-server && chmod +x /bin/babl-server
RUN pip install awscli
ADD app /bin/app
RUN chmod +x /bin/app
CMD ["babl-server"]
