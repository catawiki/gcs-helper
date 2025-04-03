FROM --platform=linux/amd64 golang:1.24-alpine3.21 AS build

COPY . ./
RUN go mod download \
    && env CGO_ENABLED=0 GOPROXY=https://proxy.golang.org go build -o gcs-helper

FROM --platform=linux/amd64 alpine:3.21.3
RUN  apk add --no-cache ca-certificates
COPY --from=build /go/gcs-helper /usr/bin/gcs-helper
ENTRYPOINT ["/usr/bin/gcs-helper"]
