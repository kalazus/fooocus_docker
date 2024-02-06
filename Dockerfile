FROM nvidia/cuda:11.8.0-base-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=on \
    SHELL=/bin/bash

RUN apt-get update -y && \
	apt-get install -y curl libgl1 libglib2.0-0 python3-pip python-is-python3 git && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/lllyasviel/Fooocus /content/app
WORKDIR /content/app

ENV TORCH_INDEX_URL="https://download.pytorch.org/whl/cu118"
ENV TORCH_COMMAND="pip install torch==2.1.2 torchvision --index-url ${TORCH_INDEX_URL}"
ENV XFORMERS_PACKAGE="xformers==0.0.23.post1"

RUN ${TORCH_COMMAND} && \
    pip install -r requirements_versions.txt --extra-index-url ${TORCH_INDEX_URL} && \
    pip install ${XFORMERS_PACKAGE}

COPY --chmod=755 scripts/* ./

WORKDIR /content

CMD /content/app/entrypoint.sh
