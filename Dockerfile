FROM golang:1.13-alpine as builder

RUN apk update && apk add git

WORKDIR /usr/src/app
COPY main.go .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o main .

FROM scratch

COPY --from=builder /usr/src/app .
CMD ["/main"]

