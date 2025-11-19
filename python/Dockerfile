# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/001-base:local

RUN sudo \
  apk add \
    python3-dev

COPY --chown=human:human ./files/code /code
COPY --chown=human:human ./files/code-fragments /code-fragments
COPY --chown=human:human ./files/how-to.md /how-to.md
COPY --chown=human:human ./files/agent-help.md /agent-help.md

