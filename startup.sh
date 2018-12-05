#!/bin/bash

# download model if necessary

if [ ! -d /deepspeech/models ]; then 
    wget https://github.com/mozilla/DeepSpeech/releases/download/v0.3.0/deepspeech-0.3.0-models.tar.gz -P /deepspeech
    tar xzf /deepspeech/deepspeech-0.3.0-models.tar.gz -C /deepspeech
    rm -f /deepspeech/deepspeech-0.3.0-models.tar
fi

echo "connect to the container and try"
echo "python2 /app/repo/stream_with_sentences.py --lang de --file /app/repo/demo.wav --models /deepspeech/models" 

while true; do
  sleep 10
  echo -n "."
done
