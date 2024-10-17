# build-container
A container pre-configured with software build tools

Primarily made for my convenience, used for testing and building software without having to pollute the host system with various packages. This image is based on `debian:sid` image. Take a look at the `apt` install line in the [Containerfile](Containerfile) to see whats included.

Using mounts (directories or volumes) for certain directories in the container can be favorable if you find yourself creating multiple containers, this helps to reduce resource consumption for certain tasks. Some examples are:

- Cache directories: `/var/cache` and `$HOME/.cache`
- `apt` data directory: `/var/lib/apt`
