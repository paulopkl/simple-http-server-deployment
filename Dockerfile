# Stage 1: Build
FROM golang:1.23 as builder

# Set the working directory inside the container
WORKDIR /app

# Copy Go modules and download dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy the source code into the container
COPY . .

# Build the Go application
# GOOS is the Operational System
# GOARCH is the architecture
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o simple-http-server main.go

# Stage 2: Final runtime image
FROM alpine:latest

# Install certificates for HTTPS support
RUN apk --no-cache add ca-certificates

# Set the working directory
WORKDIR /root/

# Copy the built binary from the builder stage
COPY --from=builder /app/simple-http-server .
# COPY --from=builder /app/html .

COPY ./html ./html

# Expose the port the application runs on
EXPOSE 8080

# Command to run the application
CMD ["./simple-http-server"]
