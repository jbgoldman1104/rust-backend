# Build Stage
FROM --platform="${BUILDPLATFORM}" rust:1.70.0-slim
USER 0:0
WORKDIR /home/rust/src

ARG TARGETARCH

# Install build requirements
RUN dpkg --add-architecture "${TARGETARCH}"
RUN apt-get update && \
    apt-get install -y \
    make \
    pkg-config \
    libssl-dev:"${TARGETARCH}"
COPY scripts/build-image-layer.sh /tmp/
COPY crates ./crates
RUN sh /tmp/build-image-layer.sh apps
