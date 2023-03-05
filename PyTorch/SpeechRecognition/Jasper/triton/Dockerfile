ARG FROM_IMAGE_NAME=nvcr.io/nvidia/tritonserver:20.10-py3-clientsdk
FROM ${FROM_IMAGE_NAME}

RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub 194
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/7fa2af80.pub

RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /usr/share/keyrings/kitware-archive-keyring.gpg >/dev/null

RUN echo 'deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ focal main' | tee /etc/apt/sources.list.d/kitware.list >/dev/null

RUN rm /usr/share/keyrings/kitware-archive-keyring.gpg

RUN apt-get install kitware-archive-keyring

RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /usr/share/keyrings/kitware-archive-keyring.gpg >/dev/null \
    && echo 'deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ focal main' | tee /etc/apt/sources.list.d/kitware.list >/dev/null


RUN apt-get update

RUN apt update --allow-insecure-repositories
RUN apt install -y python3-pyaudio libsndfile1

RUN pip3 install -U pip
RUN pip3 install onnxruntime unidecode inflect soundfile

WORKDIR /workspace/jasper
COPY . .
