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

RUN mkdir /deepspeech

WORKDIR /app


COPY . /app

RUN npm install

RUN chown -R 1001:0 /app && \
    chmod -R ug+rwX /app

RUN chmod -R 777 /tmp

RUN echo "3.0" > /etc/imageversion

USER 1001

CMD /bin/bash /app/startup.sh
