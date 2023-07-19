FROM mod-plugin-builder
ENV REBUILD=true
ENV DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"] 


# Install dependencies
RUN apt-get update \
	&& apt-get -y install --no-install-recommends virtualenv python3-pip python3-dev python3-venv libpython3.11-dev python3-setuptools git build-essential libasound2-dev libjack-jackd2-dev liblilv-dev libjpeg-dev zlib1g-dev wget curl \	
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/man/?? /usr/share/man/??_*


# Build mod-ui 
# Change this according to your distro
ENV PYTHON_VERSION 3.11  
RUN echo 2
RUN git clone https://github.com/moddevices/mod-ui.git /mod/mod-ui
RUN virtualenv /mod/mod-ui/modui-env
ENV VIRTUAL_ENV /mod/mod-ui/modui-env 
ENV PATH /mod/mod-ui/modui-env/bin:$PATH   
RUN sed -i -e 's/git+https:\/\/github.com\/dlitz\/pycrypto.git@master#egg=pycrypto/PyCryptodomex/' /mod/mod-ui/requirements.txt
RUN pip3 install -r /mod/mod-ui/requirements.txt 
RUN sed -i -e 's/collections.MutableMapping/collections.abc.MutableMapping/' /mod/mod-ui/modui-env/lib/python$PYTHON_VERSION/site-packages/tornado/httputil.py && sed -i -e 's/Image.ANTIALIAS/Image.Resampling.LANCZOS/' /mod/mod-ui/modtools/pedalboard.py && sed -i -e 's/var\ DEBUG\ \=\ true/var\ DEBUG\ \=\ false/' /mod/mod-ui/html/index.html
RUN pip3 install git+https://github.com/moddevices/browsepy.git backports.shutil-get-terminal-size scandir
COPY ./start_browsepy.sh /mod/mod-ui/modui-env/bin/
RUN chmod +x /mod/mod-ui/modui-env/bin/start_browsepy.sh && make -C /mod/mod-ui/utils && chown :audio -R /mod/mod-ui && chmod -R 775 /mod/mod-ui
RUN wget https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh -P /mod/mod-ui && chmod +x /mod/mod-ui/wait-for-it.sh


# install gosu for a better su+exec command
ARG GOSU_VERSION=1.12
RUN dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" \
	&& chmod +x /usr/local/bin/gosu \
	&& gosu nobody true 

ENV MOD_DEV_ENVIRONMENT=0 

ENV MOD_DATA_DIR /mod/data
ENV MOD_USER_FILES_DIR /mod/user-files
ENV MOD_LOG 0

# Generate user same as host . (It will need to connect to host jack with same username)

CMD echo PUID ${PUID} && echo PGID ${PGID} \
        && groupadd -f -g 1000 abc \
        && useradd -m -g 1000 -G audio -u 1000 abc -d /mod  || true  \
        && usermod -u $PUID abc \
        && groupmod -g $PGID abc \
        && gosu ${PUID} mod-host -p 5555 -f 5556 \
	&& gosu ${PUID} start_browsepy.sh $MOD_USER_FILES_DIR \
	&& gosu ${PUID} python3 /mod/mod-ui/server.py 	

