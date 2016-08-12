# Dockerised puppet-forge-server

A sample config for containerising [puppet-forge-server](https://github.com/unibet/puppet-forge-server)
using [passenger-docker](https://github.com/phusion/passenger-docker).

Configuration notes:
* The passenger-docker config exposes port 80, which should be mapped on the host.
* The storage paths defined in config.ru should be mapped as volumes (or one
  volume) mounted at `/forge/cache` and `/forge/modules`.

To quickly run on local port 80:

    docker build -t puppet_forge_server .
    docker run -v /path/to/data:/forge -p 80:80 puppet_forge_server

If you're behind an HTTP proxy, the variables can be passed through from the
environment for both building the container and running it:

    docker build --build-arg http_proxy --build-arg https_proxy -t puppet_forge_server .
    docker run -v /path/to/data:/forge -e http_proxy -e https_proxy -p 80:80 puppet_forge_server

