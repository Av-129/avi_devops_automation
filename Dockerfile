FROM public.ecr.aws/docker/library/golang:1.22.0-bookworm AS build
 
 WORKDIR /
 
 # Copy the Go modules manifest and install dependencies
 COPY go.mod go.sum ./
 RUN go mod download
 
 # Copy the rest of the application code
 COPY . .
 
 # Install build dependencies
 RUN apt-get update && apt-get install -y gcc libc-dev
 
 # Build the application
 RUN go build -o /app main.go
 
 # Stage 2: Create a minimal image with the built binary
 FROM public.ecr.aws/docker/library/golang:1.21.4-bookworm
 
 WORKDIR /
 
 # Copy the binary from the build stage
 COPY --from=build /app /app
 
 # Copy environment file
 COPY .env .env
 COPY config config
 
 EXPOSE 8000
 
 # Specify the binary to run
 CMD ["/app"]
