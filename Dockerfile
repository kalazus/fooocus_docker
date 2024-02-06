FROM pytorch/pytorch:2.1.2-cuda11.8-cudnn8-devel
ENV DEBIAN_FRONTEND noninteractive
ENV CMDARGS --share

RUN apt-get update -y && \
	apt-get install -y curl libgl1 libglib2.0-0 python3-pip python-is-python3 && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/lllyasviel/Fooocus /content/app

COPY requirements_docker.txt /content/app/requirements_versions.txt /tmp/
RUN pip install --no-cache-dir -r /tmp/requirements_docker.txt -r /tmp/requirements_versions.txt && \
	rm -f /tmp/requirements_docker.txt /tmp/requirements_versions.txt
RUN curl -fsL -o /usr/local/lib/python3.8/dist-packages/gradio/frpc_linux_amd64_v0.2 https://cdn-media.huggingface.co/frpc-gradio-0.2/frpc_linux_amd64 && \
	chmod +x /usr/local/lib/python3.8/dist-packages/gradio/frpc_linux_amd64_v0.2

RUN adduser --disabled-password --gecos '' user

COPY scripts /content/app
RUN chown -R user:user /content

WORKDIR /content
USER user

CMD /content/app/entrypoint.sh
