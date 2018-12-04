#!/bin/bash

# download model if necessary

if [ ! -d /deepspeach/models ]; then 
    wget https://github.com/mozilla/DeepSpeech/releases/download/v0.3.0/deepspeech-0.3.0-models.tar.gz -P /deepspeech
    tar xzf /deepspeech/deepspeech-0.3.0-models.tar.gz -C /deepspeech
    rm -f /deepspeech/deepspeech-0.3.0-models.tar
fi

if [ ! -d /deepspeach/gpu-demo ]
    git clone https://github.com/iboernig/openshift-ml-demo.git /deepspeech/gpu-demo

while true; do
  sleep 10
  echo "Waiting for command"
done
