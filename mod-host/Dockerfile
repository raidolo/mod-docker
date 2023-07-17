FROM debian:bookworm
ENV REBUILD=true
ENV DEBIAN_FRONTEND=noninteractive

# Install dependemcies
RUN apt-get update && apt-get install -q -y wget 

# Add KX Studio Repo, install plugins
RUN dpkg --purge kxstudio-repos-gcc5
 RUN wget https://launchpad.net/~kxstudio-debian/+archive/kxstudio/+files/kxstudio-repos_10.0.3_all.deb
 RUN dpkg -i kxstudio-repos_10.0.3_all.deb
RUN apt-get update && apt-get install -y --no-install-recommends \
        libreadline-dev liblilv-dev lilv-utils libfftw3-dev libjack-jackd2-dev git python3 python3.11

# Build mod-host
RUN git clone https://github.com/moddevices/mod-host.git /mod/mod-host/source
RUN apt install build-essential -y --no-install-recommends
# fix for Debian 12 lilv
RUN mkdir /usr/include/lilv
RUN cp /usr/include/lilv-0/lilv/lilv.h /usr/include/lilv/
#
RUN make -C /mod/mod-host/source && make install -C  /mod/mod-host/source

# Install LV2 Plugins from MOD Repo (to extract modgui data)
RUN apt-get update && apt-get install -y --no-install-recommends kxstudio-meta-audio-plugins kxstudio-meta-audio-plugins-lv2 
#RUN git clone https://github.com/moddevices/mod-lv2-data.git /mod/mod-host/mod-lv2-data
#RUN echo
#COPY ./copy_modguis.sh /mod/mod-host
#RUN chmod +x /mod/mod-host/copy_modguis.sh && bash -c  '/mod/mod-host/copy_modguis.sh' && echo
#ADD plugins.tgz /usr/lib/lv2/

# install gosu for a better su+exec command
ARG GOSU_VERSION=1.12
RUN dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" \
	&& chmod +x /usr/local/bin/gosu \
	&& gosu nobody true 


# Run mod host
# Generate user same as host . (It will need to connect to host jack with same username)
CMD echo ${USER_NAME} && echo ${GROUP_NAME} \ 
	&& groupadd -f $GROUP_ID \
	&& useradd -m -g $GROUP_ID -G audio -u $USER_ID $USER_NAME || true  \
	# && rsync /mod/mod/* -rElu /mod/${USER_NAME} \ 
	# && chown -R ${USER_NAME}:${GROUP_ID} /home/${USER_NAME} \
	# && ls -la /usr/lib/lv2 \
	# && /bin/bash 
	&& gosu ${USER_NAME} mod-host -v -n -p 5555
