FROM gcr.io/cloud-builders/go:alpine as build

COPY . ./
RUN go mod download \
    && env CGO_ENABLED=0 GO111MODULE=on GOPROXY=https://proxy.golang.org go build -o gcs-helper

FROM alpine:3.9
RUN  apk add --no-cache ca-certificates
COPY --from=build /go/gcs-helper /usr/bin/gcs-helper
ENTRYPOINT ["/usr/bin/gcs-helper"]
