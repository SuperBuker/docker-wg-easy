ARG label=edge

FROM ghcr.io/wg-easy/wg-easy:${label}

# Copy rootfs
COPY rootfs/ /

# Fix shell
SHELL ["/bin/sh", "-o", "pipefail", "-c"]

# Metadata
LABEL org.opencontainers.image.source="https://github.com/SuperBuker/wg-easy"
