FROM fedora:29


LABEL ios.k8s.display-name="deepspeech" \
    maintainer="Keith Tenzer <ktenzer@redhat.com>"

RUN dnf groupinstall -y 'C Development Tools and Libraries'
RUN dnf install -y python3 \
    python3-devel \
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

RUN pip3 install 'deepspeech==0.3.0' \
    'googletrans==4.0.0-rc1' \
    jamspell \
    webrtcvad \
    requests \
    certifi \
    urllib3 \
    idna \
    chardet

#RUN cd /tmp/deepspeech && \
#    git clone https://github.com/alainrouillon/py-googletrans.git && \
#    cd /tmp/deepspeech/py-googletrans && \
#    git checkout origin/feature/enhance-use-of-direct-api && \
#    python2 /tmp/deepspeech/py-googletrans/setup.py install && \
#    rm -rf /tmp/deepspeech  

RUN mkdir /app

RUN mkdir /deepspeech

WORKDIR /app

COPY . /app

RUN npm install

RUN chown -R 1001:0 /app && \
    chown -R 1001:0 /deepspeech && \
    chmod -R ug+rwX /app && \
    chmod -R ug+rwX /deepspeech


RUN chmod -R 777 /tmp

RUN echo "3.0" > /etc/imageversion

USER 1001

CMD /bin/bash /app/startup.sh
