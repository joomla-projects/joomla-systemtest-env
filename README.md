Joomla Systemtest Environment
===========

This is a Docker Image with Selenium Server, Xvfb, Firefox and Chromium installed. SeleniumEnv was created to run Selenium tests without installing Selenium and its dependencies. Selenium server is executed inside a container.

## Installation

Build the image by yourself. Just clone this repo and run

```
docker build -t joomlasystest-env .
```

you should edit Dockerfile in order to customize version of Selenium Server.

## Usage

Run the container

```
docker run -i -t joomlasystest-env
```

