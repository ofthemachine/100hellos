# syntax=docker/dockerfile:1
# escape=\
FROM 100hellos/000-base:local

# Install Nix package manager - single user install for MUSL compatibility
RUN sudo apk add --no-cache xz coreutils

# Install Nix using the single-user installation which is MUSL compatible
RUN curl -L https://nixos.org/nix/install | sh -s -- --no-daemon

# Add Nix to PATH for the human user
RUN echo 'source /home/human/.nix-profile/etc/profile.d/nix.sh' >> /home/human/.profile
RUN echo 'source /home/human/.nix-profile/etc/profile.d/nix.sh' >> /home/human/.zshrc

# Ensure Nix tools are available in the system PATH by creating symlinks
RUN sudo ln -sf /home/human/.nix-profile/bin/nix-shell /usr/local/bin/nix-shell
RUN sudo ln -sf /home/human/.nix-profile/bin/nix-instantiate /usr/local/bin/nix-instantiate

COPY --chown=human:human ./files /hello-world
COPY --chown=human:human ./fraglet /

ENTRYPOINT [ "/fraglet-entrypoint" ]
