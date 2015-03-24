#!/usr/bin/env bash

sudo docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock --name test_harness test_flask_service
