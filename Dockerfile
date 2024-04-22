FROM golang:1.18.1 AS build

RUN mkdir -p /go/src/app/vault_token_generator

WORKDIR /go/src/app/vault_token_generator

COPY . .

RUN GO111MODULE=on CGO_ENABLED=0 go install

FROM alpine:3.16.2 AS run

RUN apk add --no-cache ca-certificates

COPY --from=build /go/bin/vault_token_generator /bin/vault_token_generator

ENTRYPOINT [ "/bin/vault_token_generator" ]
