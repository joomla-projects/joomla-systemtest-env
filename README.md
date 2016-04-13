Joomla Systemtest Environment
===========

This is a Docker Image with Selenium Server, Xvfb, Firefox and Chromium installed. SeleniumEnv was created to run Selenium tests without installing Selenium and its dependencies. Selenium server is executed inside a container.

This image is used to run the Joomla Systemtest suite and is based on the SeleniumEnv Image by Codeception: https://github.com/Codeception/SeleniumEnv

## Installation

Build the image by yourself. Just clone this repo and run:

```
docker build -t joomlasystest-env .
```

you should edit Dockerfile in order to customize version of Selenium Server.

## Usage

Run the container

```
docker run -i -t joomlasystest-env
```

If you want to run the test suite on a specific repo, append it as an environment variable

```
docker run -i -t -e REPO=https://github.com/joomla/joomla-cms joomlasystest-env
```

If you want to run the test suite on a specific branch, append it as an environment variable

```
docker run -i -t -e BRANCH=staging joomlasystest-env
```

After the test has been completed, you can extract the result file:

```
docker cp CONTAINERID:/usr/share/nginx/www/joomla-cms/tests/system/webdriver/tests/logs/junit.xml /target/path
````

## More info
More info at https://docs.joomla.org/Docker_Container_for_System_Tests
