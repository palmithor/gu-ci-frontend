#!/usr/bin/env bash
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
sudo echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
sudo curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
sudo apt-get update -y && apt-get install google-cloud-sdk -y