FROM golang:1.23rc2-alpine3.20 AS builder
WORKDIR /go/src
COPY . .

RUN export CGO_ENABLED=0 && go install && go build -o /

FROM golang:1.23rc2-alpine3.20 AS runtime
WORKDIR /app

RUN apk update && apk add --no-cache git

COPY --from=builder /shhgit /app

ENTRYPOINT [ "/app/shhgit" ]