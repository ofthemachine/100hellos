FROM alpine:latest

# Install Python and pip in virtual environment
RUN apk add --no-cache python3 py3-pip py3-virtualenv

# Create virtual environment and install qsharp
RUN python3 -m venv /opt/qsharp-env \
    && source /opt/qsharp-env/bin/activate \
    && pip install --upgrade pip \
    && pip install qsharp

# Create wrapper script
RUN echo '#!/bin/sh' > /usr/local/bin/qsharp-python \
    && echo 'source /opt/qsharp-env/bin/activate && python3 "$@"' >> /usr/local/bin/qsharp-python \
    && chmod +x /usr/local/bin/qsharp-python

COPY hello.py /hello.py
COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]