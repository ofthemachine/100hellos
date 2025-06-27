FROM alpine:latest

# Install wget and basic tools for AppImage
RUN apk add --no-cache wget curl

# MiniZinc via AppImage (self-contained, musl-compatible)
WORKDIR /opt
RUN wget -O MiniZinc.AppImage https://github.com/MiniZinc/MiniZincIDE/releases/download/2.9.3/MiniZincIDE-2.9.3-x86_64.AppImage \
    && chmod +x MiniZinc.AppImage

# Create wrapper script since AppImage needs FUSE (not available in containers)
RUN ./MiniZinc.AppImage --appimage-extract \
    && mv squashfs-root /opt/minizinc \
    && rm MiniZinc.AppImage

# Add to PATH
ENV PATH="/opt/minizinc/usr/bin:${PATH}"

COPY hello.mzn /hello.mzn
COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]