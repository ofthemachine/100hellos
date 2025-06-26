# syntax=docker/dockerfile:1
FROM 100hellos/000-base:local

# Install Python and pip for Cirq quantum computing framework
RUN sudo apk add --no-cache python3 py3-pip

# Create virtual environment and install cirq-core (lightweight version)
USER human
RUN python3 -m venv /home/human/cirq-env \
    && source /home/human/cirq-env/bin/activate \
    && pip install --upgrade pip \
    && pip install cirq-core

# Switch back to root to create wrapper script
USER root
RUN echo '#!/bin/sh' > /usr/local/bin/cirq-python \
    && echo 'source /home/human/cirq-env/bin/activate && python3 "$@"' >> /usr/local/bin/cirq-python \
    && chmod +x /usr/local/bin/cirq-python

USER human
COPY --chown=human:human ./files /hello-world
