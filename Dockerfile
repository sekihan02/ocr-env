# FROM ubuntu:latest
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    bash \
    sudo wget vim cmake \
    coreutils \
    grep \
    iproute2 \
    iputils-ping \
    traceroute \
    tcpdump \
    bind9-dnsutils \
    dnsmasq-base \
    netcat-openbsd \
    iptables \
    procps \
    isc-dhcp-client \
    git \
    curl \
    ca-certificates \
    tzdata \
    libopencv-dev \
    opencv-data \
    libglib2.0-0 \
    libsm6 \
    libxrender1 \
    libxext6 \
    ffmpeg \
    python3.9 \
    python3 python3-pip \
    python3-dev \
    python3-pip \
    python3-wheel \
    python3-setuptools \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# libglib2.0-0 libsm6 libxrender1 libxext6はopencvの関連パッケージ
# これは重いのでbuild後にインストールするのが良いかも
RUN apt-get update -y && apt-get install -y --no-install-recommends build-essential gcc libsndfile1

RUN add-apt-repository ppa:deadsnakes/ppa

RUN add-apt-repository ppa:alex-p/tesseract-ocr5
RUN apt install -y tesseract-ocr libtesseract-dev
RUN apt install -y tesseract-ocr-jpn  tesseract-ocr-jpn-vert tesseract-ocr-script-jpan tesseract-ocr-script-jpan-vert

# userにユーザを変更
USER ${USERNAME}


RUN mkdir $HOME/app
# ワークスペースをインストールフォルダに変更
WORKDIR $HOME/app

COPY requirements.txt .
RUN pip3 install --upgrade pip

RUN pip3 install spacy
RUN python3 -m spacy download en 
RUN python3 -m spacy download en_core_web_lg

RUN pip3 install --no-cache-dir -r requirements.txt

# ワークスペースを元に戻す
WORKDIR /

RUN mkdir /work

USER ${USERNAME}

# runした時にjupyter labをlocalhostで起動し、root、パスなし
# アクセスはブラウザでlocalhost:8888
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--LabApp.token=''"]
# CMD ["bash", "-l"]
# CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--LabApp.token=''", "--NotebookApp.trust_xheaders=True", "--NotebookApp.disable_check_xsrf=True"]
