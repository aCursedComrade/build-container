# https://docs.docker.com/build/building/best-practices/
FROM debian:sid
ARG DEBUG

LABEL org.opencontainers.image.authors="Loshana Aloka <https://comradelab.win/>"
LABEL org.opencontainers.image.source="https://github.com/aCursedComrade/build-container"
LABEL org.opencontainers.image.description="A container with pre-configured software build tools"
LABEL org.opencontainers.image.licenses="MIT"

RUN rm -f /etc/apt/apt.conf.d/docker-clean && \
    echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' | tee /etc/apt/apt.conf.d/keep-cache

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update && apt-get --no-install-recommends -y install \
        build-essential

# Using a non-root user is preferable in certain edge cases where tools
# refuse to run as `root` or if it aligns with your threat model (generally a
# good idea). However, dealing with mounts can be annoying due to different
# UID maps
# https://rootlesscontaine.rs/
# https://www.redhat.com/en/blog/rootless-podman-user-namespace-modes
# https://www.redhat.com/en/blog/rootless-podman-makes-sense
#RUN useradd --no-log-init -m buildman
#USER buildman

CMD ["bash"]
