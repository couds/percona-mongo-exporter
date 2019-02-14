FROM golang:1.10 as builder
LABEL Maintainer="john.elric@gmail.com"
WORKDIR /go/src/github.com/percona/
RUN git clone https://github.com/percona/mongodb_exporter.git
WORKDIR /go/src/github.com/percona/mongodb_exporter
RUN git checkout v0.6.3
RUN make init build

FROM alpine:3.9
COPY --from=builder /go/src/github.com/percona/mongodb_exporter/mongodb_exporter /usr/local/bin/mongodb_exporter
ENV MONGODB_URI mongodb://localhost:27017
EXPOSE  9216
ENTRYPOINT [ "mongodb_exporter" ]