# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/000-base:local

# Install node (for npm), npm (for elm), and w3m (to render the html)
RUN sudo apk add --no-cache nodejs npm w3m

# Install elm via npm
RUN sudo npm install -g elm

# Copy the hello-world files
COPY --chown=human:human ./files /hello-world
