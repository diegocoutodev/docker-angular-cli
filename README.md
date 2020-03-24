# docker-angular-cli

A simple Docker Image to [Angular](https://angular.io/docs) CLI that you shoud user in development environment.

[![GitHub forks](https://img.shields.io/github/forks/diegocoutodev/docker-angular-cli.svg?style=social&label=Fork)](https://github.com/diegocoutodev/docker-angular-cli/fork) [![GitHub stars](https://img.shields.io/github/stars/diegocoutodev/docker-angular-cli?style=social&label=Star)](https://github.com/diegocoutodev/docker-angular-cli)

## Table of contents
  - [Building Image](#building-image)
  - [Examples](#examples)
    - [Generate a project](#generate-a-project)
    - [Generate a component](#generate-a-component)
    - [Run an existing project](#run-an-existing-project)

## Building Image

First of all, you need clone this project from Github.

```
$ git clone https://github.com/diegocoutodev/docker-angular-cli && cd docker-angular-cli
```

If you want to build an image with a specific version of the [@angular/cli](https://www.npmjs.com/package/@angular/cli), then use the `NG_VERSION` build variable.

```
$ export NG_VERSION=8.3.20 && docker build . --build-arg NG_VERSION=$NG_VERSION -t angular-cli:$NG_VERSION
```

If you prefer the latest version, just execute:

```
$ docker build . -t angular-cli
```

## Examples

### Generate a project

We will create a project called `myapp` under `$PWD` directory, typing the follow command:

```
$ docker run --rm -u $(id -u):$(id -g) -v $PWD:/webapp -v $HOME/.cache:/.cache diegocoutodev/angular-cli new myapp
```

### Generate a component

Based on project created [previously](#generate-a-project), so execute:

```
$ cd $HOME/myapp \
  && docker run --rm -u $(id -u):$(id -g) -v $PWD:/app diegocoutodev/angular-cli g c mycomponent
```

### Run an existing project

Considering the scenario previously showed, you can run this command bellow.

```
$ docker run --rm -u $(id -u):$(id -g) -v $PWD:/app -p 4200:4200 diegocoutodev/angular-cli serve --host 0.0.0.0
```

If you prefer, use a solution based on `docker-compose.yaml`.

```yaml
version: '3.7'
services:
    webapp:
        image: diegocoutodev/angular-cli
        container_name: "mywebapp"
        image: angular-cli
        restart: always
        command: serve --host 0.0.0.0
        ports:
            - "4200:4200"
        volumes:
           - ./myapp:/webapp
        networks:
            - ng-network
networks:
    ng-network:
```
