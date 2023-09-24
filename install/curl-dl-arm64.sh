#!/bin/sh
set -e

mkdir -p /tmp/curl-dl && cd /tmp/curl-dl
curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
cd - > /dev/null
