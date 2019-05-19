FROM nvidia/cuda:9.0-cudnn7-devel

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    python3-dev python3-pip python3-wheel python3-setuptools \
    git cmake nano wget \
    libblas3 libblas-dev \
    libglib2.0 libsm6 libxext6 libxrender1 \
    && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

# Python command setting
RUN ln -s /usr/bin/python3 /usr/local/bin/python && \
    ln -s /usr/bin/pip3 /usr/local/bin/pip

# Python libraries
RUN pip install --upgrade pip
RUN pip install jupyter matplotlib pandas scipy scikit-learn Pillow
RUN pip install beautifulsoup4 lxml tqdm
RUN pip install xgboost
RUN pip install cupy-cuda90 chainer==5.4 chainercv==0.12
RUN pip install --user --upgrade tensorflow-gpu
RUN pip install keras
RUN pip install PySide2 opencv-python
RUN pip install 'ideep4py<2.1'

# Jupyter
USER root
EXPOSE 8888
WORKDIR "/root/notebooks"
#COPY jupyter_notebook_config.py /root/.jupyter/
COPY run_jupyter.sh /
RUN chmod +x /run_jupyter.sh
#CMD ["/run_jupyter.sh", "--ip=0.0.0.0", "--allow-root"]
