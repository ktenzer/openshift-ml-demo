#!/bin/bash

# download models if necessary
if [ ! -d /deepspeech/models ]; then 
    echo "Downloading deepspeech models"
    wget https://github.com/mozilla/DeepSpeech/releases/download/v0.3.0/deepspeech-0.3.0-models.tar.gz -P /deepspeech
    tar xzf /deepspeech/deepspeech-0.3.0-models.tar.gz -C /deepspeech
    rm -f /deepspeech/deepspeech-0.3.0-models.tar.gz
fi

if [ ! -f /deepspeech/models/en.bin ]; then 
    echo "Downloading en spelling models for jamspell"
    wget https://github.com/bakwc/JamSpell-models/raw/master/en.tar.gz -P /deepspeech
    tar xzf /deepspeech/en.tar.gz -C /deepspeech/models
    rm -f /deepspeech/en.tar.gz
fi

if [ ! -f /deepspeech/models/fr.bin ]; then 
    echo "Downloading fr spelling models for jamspell"
    wget https://github.com/bakwc/JamSpell-models/raw/master/fr.tar.gz -P /deepspeech
    tar xzf /deepspeech/fr.tar.gz -C /deepspeech/models
    rm -f /deepspeech/fr.tar.gz
fi

if [ ! -f /deepspeech/models/ru.bin ]; then 
    echo "Downloading ru spelling models for jamspell"
    wget https://github.com/bakwc/JamSpell-models/raw/master/ru.tar.gz -P /deepspeech
    tar xzf /deepspeech/ru.tar.gz -C /deepspeech/models
    rm -f /deepspeech/ru.tar.gz
fi

if [ -f /deepspeech/models/ru_small.bin ]; then 
    echo "Renaming ru spell model"
   mv /deepspeech/models/ru_small.bin /deepspeech/models/ru.bin
fi

echo "Starting nodejs"
npm start
