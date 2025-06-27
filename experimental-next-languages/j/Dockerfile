FROM alpine:latest

# Install wget for downloading J
RUN apk add --no-cache wget tar

# Download and install J language
WORKDIR /opt
RUN wget https://www.jsoftware.com/download/j902/install/j902_linux64.tar.gz \
    && tar -xzf j902_linux64.tar.gz \
    && rm j902_linux64.tar.gz

# Create symlink for easy access
RUN ln -s /opt/j902/bin/jconsole /usr/local/bin/j

COPY hello.ijs /hello.ijs
COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]