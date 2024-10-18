# https://docs.docker.com/build/building/best-practices/
FROM debian:sid

LABEL org.opencontainers.image.authors="Loshana Aloka <acursed_comrde@yahoo.com>"
LABEL org.opencontainers.image.source="https://github.com/aCursedComrade/build-container"
LABEL org.opencontainers.image.description="A container with pre-configured software build tools"
LABEL org.opencontainers.image.licenses="MIT"

RUN rm -f /etc/apt/apt.conf.d/docker-clean && \
    echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' | tee /etc/apt/apt.conf.d/keep-cache

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update && apt-get --no-install-recommends -y install \
        build-essential \
        ca-certificates \
        cmake \
        curl \
        git \
        less \
        meson \
        nano \
        nasm \
        ninja-build \
        unzip \
        vim \
        wget \
        zip \
        zsh

# Using a non-root user is preferable in certain edge cases where tools
# refuse to run as `root` or if it aligns with your threat model (generally a
# good idea). However, dealing with mounts can be annoying due to different
# UID maps in rootless mode.
# https://rootlesscontaine.rs/
# https://www.redhat.com/en/blog/rootless-podman-user-namespace-modes
# https://www.redhat.com/en/blog/rootless-podman-makes-sense
#RUN useradd -m buildman
#USER buildman

RUN ["chsh", "-s", "/usr/bin/zsh"]
COPY src/zshrc /root/.zshrc

CMD ["zsh", "-i"]
