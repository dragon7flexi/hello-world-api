# Step 1: Build the Go application
FROM golang:1.19 as build

WORKDIR /app

# Copy go mod and sum files
COPY go.mod go.sum ./

# Install dependencies
RUN go mod tidy

# Copy the source code
COPY . .

# Build the Go app
RUN go build -o myapp .

# Step 2: Create the final image with the prebuilt Go app
FROM debian:bullseye-slim

WORKDIR /root/

# Copy the compiled Go binary from the build stage
COPY --from=build /app/myapp .

# Expose the port that the app will run on (adjust if necessary)
EXPOSE 80

# Command to run the Go application
CMD ["./myapp"]
