#!/usr/bin/env bash

sudo docker build -t flask_service -f flask_service.dockerfile .
sudo docker build -t test_flask_service -f test_flask_service.dockerfile .