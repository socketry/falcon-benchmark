FROM golang:latest AS build
WORKDIR /srv/http
COPY setup/go/srv/http/ /srv/http/
RUN go mod init benchmark && go build -o server main.go

FROM debian:stable-slim
WORKDIR /srv/http
COPY --from=build /srv/http/server /srv/http/server
EXPOSE 80
CMD ["./server"]
