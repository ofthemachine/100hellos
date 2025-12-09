# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/000-base:local

RUN sudo \
  apk add --no-cache \
    octave

# Set environment variables to silence X11/GUI warnings
ENV DISPLAY=""
ENV OCTAVE_DISPLAY=""

COPY --chown=human:human ./files /hello-world
COPY --chown=human:human ./fraglet /

ENTRYPOINT [ "/fraglet-entrypoint" ]
