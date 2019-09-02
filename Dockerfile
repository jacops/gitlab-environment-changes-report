ARG GOLANG_IMAGE=golang
ARG GOLANG_IMAGE_TAG=latest

FROM ${GOLANG_IMAGE}:${GOLANG_IMAGE_TAG} as builder

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

FROM alpine:latest

RUN apk --no-cache add ca-certificates

WORKDIR /root/

COPY --from=builder /app/main .

ENTRYPOINT ["./main"]