FROM fedora:latest


LABEL ios.k8s.display-name="deepspeech" \
    maintainer="Keith Tenzer <ktenzer@redhat.com>"

RUN dnf groupinstall -y 'C Development Tools and Libraries'
RUN dnf install -y python2 \
    python2-devel \
    git \
    wget \
    swig \
    langpacks-de \
    langpacks-es \
    langpacks-fr \
    langpacks-pl

RUN mkdir -p /tmp/deepspeech

RUN pip2 install 'deepspeech==0.3.0' \
    jamspell \
    webrtcvad \
    requests \
    certifi \
    urllib3 \
    idna \
    chardet

RUN cd /tmp/deepspeech && \
    git clone https://github.com/BoseCorp/py-googletrans.git && \
    cd /tmp/deepspeech/py-googletrans && \
    python2 /tmp/deepspeech/py-googletrans/setup.py install

RUN rm -rf /tmp/deepspeech

RUN mkdir /app

RUN git clone https://github.com/ktenzer/openshift-ml-demo.git /deepspeech/openshift-ml-demo

RUN mkdir /deepspeech

RUN echo "2.0" > /etc/imageversion

CMD /bin/bash /app/repo/startup.sh
