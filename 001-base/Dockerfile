# syntax=docker/dockerfile:1
# Multi-stage build for Go entrypoint tool

# Build stage
FROM golang:1.21-alpine AS builder

WORKDIR /build

# Copy go mod files
COPY go.mod go.sum* ./
RUN go mod download

# Copy source code
COPY cmd/ ./cmd/
COPY internal/ ./internal/

# Build static binary
# CGO_ENABLED=0: Disables CGO for a static binary (no C library dependencies)
#                Necessary for Alpine Linux (musl libc) to avoid glibc compatibility issues
# GOOS=linux:    Sets target OS to Linux (required since container runs on Linux)
RUN CGO_ENABLED=0 GOOS=linux go build -o entrypoint ./cmd/entrypoint

# Final stage
FROM 100hellos/base:latest

# Copy the binary from builder
COPY --from=builder --chown=human:human /build/entrypoint /entrypoint
RUN chmod +x /entrypoint

# Copy default configuration file
COPY --chown=human:human ./files/entrypoint.json /entrypoint.json

# Ensure code-fragments directory exists
RUN sudo mkdir -p /code-fragments && sudo chown human:human /code-fragments

ENTRYPOINT [ "/entrypoint" ]
