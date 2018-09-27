FROM alpine:latest as builder
LABEL Version="1.1" Maintainer="Adeel Ahmad <adeel@coefficientdata.io>"
LABEL Description="This image is used to start the Packer executable" 

ENV PACKER_VERSION=1.3.1

ADD https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip ./
RUN unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /bin
RUN rm -f packer_${PACKER_VERSION}_linux_amd64.zip

FROM alpine:latest
RUN apk add --update git bash openssl
COPY --from=builder /bin/packer /bin/
ENTRYPOINT ["/bin/packer"]
