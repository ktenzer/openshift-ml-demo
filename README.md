# openshift-ml-demo
Uses deepspeech and tensorflow to recognize voice recording in english and translate using google translate to the desired language. Output of what was recognized in the recording and translation done to stdout.

The inital work using deepspeech and google translate was done by [melwitt](https://github.com/melwitt/gpu-demo.git). 

## Prerequisites
* A wave file recorded in English using 16Khz and mono. Should be saved as 16bit PCM.
* Python2
* Python2-devel
* Development tools and libraries (gcc, etc)
* Python modules
  * deepspeech or deepspeech-gpu
  * googletrans
  * jamspell
  * numpy
  * webrtcvad

## Usage
The translation language can be anything supported by [google translate](https://cloud.google.com/translate/docs/languages). Use the ISO-639-1 code. Out-of-the-box en, de, es, pl and fr are supported as those language packs are installed. If you would like additional languages you need to update Dockerfile and add them.

### Docker
```
$ docker pull ktenzer/deepspeech:latest
```
```
$ docker run -i -t <image id>
```
```
$ /deepspeech/python2 stream_with_sentences.py --lang <en|de|es|pl> --file </path/to/.wav> --models </path/to/models>
```

## Building in OpenShift
```
$ oc new-app https://github.com/ktenzer/openshift-ml-demo.git
```
