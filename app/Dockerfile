FROM golang:1.17.1-buster as builder

WORKDIR /app

COPY go.mod .
COPY go.sum .

RUN go mod download

COPY app app/

RUN CGO_ENABLED=0 GOOS=linux go build -v -o /app/server ./app/cmd

FROM gcr.io/distroless/static-debian10 as run

COPY --from=builder /app/server /server

CMD ["/server"]