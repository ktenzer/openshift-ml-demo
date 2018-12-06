FROM fedora:latest


LABEL ios.k8s.display-name="deepspeech" \
    maintainer="Keith Tenzer <ktenzer@redhat.com>"

RUN dnf groupinstall -y 'C Development Tools and Libraries'
RUN dnf install -y python2 \
    python2-devel \
    git \
    wget \
    swig \
    npm \
    langpacks-de \
    langpacks-es \
    langpacks-fr \
    langpacks-pl 

RUN node -v
RUN npm -v

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

RUN git clone https://github.com/ktenzer/openshift-ml-demo.git /app/repo

RUN mkdir /deepspeech

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package.json /usr/src/app/
RUN npm install

COPY . /usr/src/app

RUN chown -R 1001:0 /usr/src/app
RUN chmod -R ug+rwx /usr/src/app

RUN echo "2.0" > /etc/imageversion

USER 1001

CMD /bin/bash /app/repo/startup.sh
