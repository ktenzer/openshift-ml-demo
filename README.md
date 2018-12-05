# openshift-ml-demo
This is a machine learning demo that uses deepspeech and tensorflow to recognize voice recording in english and translate using google translate to the desired language. Output of what was recognized in the recording and translation done to stdout.

The inital work using deepspeech and google translate was done by [melwitt](https://github.com/melwitt/gpu-demo.git). 

We are not using GPU in this demo but rather CPU. Performance would be likely higher using GPU. To use gpu the deepspeech-gpu python module is needed instead of deepspeech and of course nvidia driver and nvidia cuda framework, otherwise there should be no difference.

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

Note: all prerequisites are taken care of by the Dockerfile so this is just provided for information if you want to build this machine learning stack yourself.

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
A python script is provided in the container under the /deepspeech directory. It takes a translation language, path to a wave file and path to pre-built machine learned models. The script will decode the audo file and output audo to text and at the same time translate to the translation language. Accuracy and error correction on text are also performed. 

Note: The machine learned models are very basic and as such accuracy is not nearly as high as it could be. I estimate around 60%. For real-world usage a much more robust model is needed.
```
$ /deepspeech/openshift-ml-demo/python2 stream_with_sentences.py --lang <en|de|es|pl> --file </path/to/.wav> --models </path/to/models>
```
