# openshift-ml-demo
This is a machine learning demo that uses deepspeech and tensorflow to recognize voice recording in english and translate using google translate to the desired language. Output of what was recognized in the recording and translation done to stdout.

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

## Language Support
The translation language can be anything supported by [google translate](https://cloud.google.com/translate/docs/languages). Use the ISO-639-1 code. Language packs for en, de, es, pl and fr are installed out-of-the-box. If you would like additional languages you need to update Dockerfile and add them.

### Running in Docker
```
$ docker pull ktenzer/deepspeech:latest
```
```
$ docker run -i -t <image id>
```

## Running in OpenShift
```
$ oc new-app https://github.com/ktenzer/openshift-ml-demo.git
```

## Usage
A python script is provided in the container under the /deepspeech directory. It takes a translation language, path to a wave file and path to pre-built machine learned models. The script will decode the audo file and output audo to text and at the same time translate to the translation language. Accuracy and error correction on text are also performed. The machine learned models are very basic and as such accuracy is not nearly as high as it could be. For real-world usage a much more robust model is needed.
```
$ /deepspeech/python2 stream_with_sentences.py --lang <en|de|es|pl> --file </path/to/.wav> --models </path/to/models>
```
