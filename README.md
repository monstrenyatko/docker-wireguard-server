WireGuard server Docker image
=============================

[![](https://github.com/monstrenyatko/docker-wireguard-server/workflows/ci/badge.svg?branch=main)](https://github.com/monstrenyatko/docker-wireguard-server/actions?query=workflow%3Aci)

About
=====

[WireGuard](https://www.wireguard.com/) server in the `Docker` container.

Upstream Links
--------------
* Docker Registry @[monstrenyatko/wireguard-server](https://hub.docker.com/r/monstrenyatko/wireguard-server/)
* GitHub @[monstrenyatko/docker-wireguard-server](https://github.com/monstrenyatko/docker-wireguard-server)

Quick Start
===========

* Prepare `Docker` host kernel

  - The `WireGuard` kernel module must be available in `Docker` host kernel
  - See official installation [instructions](https://www.wireguard.com/install/), usually, it is as trivial as:

  ```sh
    sudo apt install wireguard
  ```

* Configure environment:

  - `WIREGUARD_SERVER_PORT`: the `WireGuard` server listening port number, make sure to use same value in the config file

    ```sh
      export WIREGUARD_SERVER_PORT=51820
    ```
  - `WIREGUARD_SERVER_CONFIG`: path to `config` file:

    ```sh
      export WIREGUARD_SERVER_CONFIG="<path-to-wireguard-config-file>"
    ```
  - `DOCKER_REGISTRY`: [**OPTIONAL**] registry prefix to pull image from a custom `Docker` registry:

    ```sh
      export DOCKER_REGISTRY="my_registry_hostname:5000/"
    ```
* Pull prebuilt `Docker` image:

  ```sh
    docker-compose pull
  ```
* Start prebuilt image:

  ```sh
    docker-compose up -d
  ```
* Stop/Restart:

  ```sh
    docker-compose stop
    docker-compose start
  ```

Build own image
===============

* `default` target platform:

  ```sh
    cd <path to sources>
    DOCKER_BUILDKIT=1 docker build --tag <tag name> .
  ```
* `arm/v6` target platform:

  ```sh
    cd <path to sources>
    DOCKER_BUILDKIT=1 docker build --platform=linux/arm/v6 --tag <tag name> .
  ```
