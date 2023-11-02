# Use the official Alpine image as a base
FROM alpine:latest

# Install iperf3
RUN apk add --no-cache iperf3

# Expose the default iperf3 server port
EXPOSE 5201

# Run iperf3 server by default
ENTRYPOINT ["iperf3"]
CMD ["-s"]