FROM golang:1.13-alpine as builder

RUN apk update && apk add git

WORKDIR /usr/src/app
COPY main.go .

# 디렉터리 안의 Go 파일들을 빌드해서 main 이라는 바이너리 파일을 현재 디렉터리에 생성

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o main .

FROM scratch

COPY --from=builder /usr/src/app .
CMD ["/main"]

