FROM debian:bookworm
ENV REBUILD=true
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -q -y wget 

# Add KX Studio Repo, install plugins
# Install LV2 Plugins from MOD Repo (to extract modgui data)

RUN dpkg --purge kxstudio-repos-gcc5 && wget https://launchpad.net/~kxstudio-debian/+archive/kxstudio/+files/kxstudio-repos_10.0.3_all.deb && dpkg -i kxstudio-repos_10.0.3_all.deb && wget http://ftp.it.debian.org/debian/pool/main/l/lv2/lv2-dev_1.18.4-2_amd64.deb && dpkg -i lv2-dev_1.18.4-2_amd64.deb &&  apt-get update && apt-get install -y --no-install-recommends \
        libreadline-dev liblilv-dev lilv-utils libfftw3-dev libjack-jackd2-dev git python3 python3.11 kxstudio-meta-audio-plugins kxstudio-meta-audio-plugins-lv2 build-essential 

# Build mod-host
RUN git clone https://github.com/moddevices/mod-host.git /mod/mod-host/source 
# fix for Debian 12 lilv
RUN mkdir /usr/include/lilv && cp /usr/include/lilv-0/lilv/lilv.h /usr/include/lilv/ && make -C /mod/mod-host/source && make install -C  /mod/mod-host/source

# install gosu for a better su+exec command
ARG GOSU_VERSION=1.12
RUN dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" \
	&& chmod +x /usr/local/bin/gosu \
	&& gosu nobody true 

ARG PUID=${PUID}
ARG PGID=${PGID}

RUN echo PUID ${PUID} && echo PDGID ${PGID} \
        && groupadd -f -g 1000 abc \
        && useradd -m -g 1000 -G audio -u 1000 abc -d /mod  || true  \
        && usermod -u ${PUID} abc \
        && groupmod -g ${PGID} abc \
        && chown ${PUID}:${PGID} /mod


# Run mod host
# Generate user same as host . (It will need to connect to host jack with same username)
CMD echo PUID ${PUID} && echo PGID ${PGID} \ 
	&& groupadd -f -g 1000 abc \
	&& useradd -m -g 1000 -G audio -u 1000 abc -d /mod  || true  \
	&& usermod -u ${PUID} abc \
	&& groupmod -g ${PGID} abc \
	&& chown ${PUID}:${PGID} /mod  \
	&& gosu $PUID mod-host -v -n -p 5555
