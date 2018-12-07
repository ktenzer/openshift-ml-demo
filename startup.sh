#!/bin/bash

# download model if necessary

if [ ! -d /deepspeech/models ]; then 
    wget https://github.com/mozilla/DeepSpeech/releases/download/v0.3.0/deepspeech-0.3.0-models.tar.gz -P /deepspeech
    tar xzf /deepspeech/deepspeech-0.3.0-models.tar.gz -C /deepspeech
    rm -f /deepspeech/deepspeech-0.3.0-models.tar
fi

npm start
