FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive
### system update
RUN apt-get update
RUN apt-get upgrade -y

### additional package
RUN apt-get install -y curl wget git vim

### ja_JP.UTF-8 Locale
RUN apt-get install -y language-pack-ja
#    update-locale LANG=ja_JP.UTF-8

### User add
RUN useradd ubuntu -m -s /bin/bash && \
    echo "ubuntu ALL = NOPASSWD: ALL" >  /etc/sudoers.d/ubuntu

### ipython
RUN apt-get install -y python-pip libpython-dev && \
    apt-get install -y g++ gfortran libopenblas-dev liblapack-dev && \
    apt-get install -y build-essential python-tk tk-dev libpng12-dev

RUN pip install numpy scipy nose tornado matplotlib pyzmq jinja2 jsonschema
RUN pip install ipython pandas sympy pygments networkx
RUN pip install quantities scikit-learn pyreadline

### Fabric
RUN pip install fabric cuisine envassert ecdsa pycrypto

### Notebook Dir
RUN mkdir /notebooks && chown ubuntu:ubuntu /notebooks

ENV LANG ja_JP.UTF-8

USER ubuntu

VOLUME /notebooks
WORKDIR /notebooks

EXPOSE 8888

CMD ["ipython","notebook","--ip=0.0.0.0","--port=8888","--notebook-dir=/notebooks","--no-browser"]

