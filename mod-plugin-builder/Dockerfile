FROM mod-host
ENV REBUILD=true
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -q -y acl bc curl cvs git mercurial \
        rsync subversion wget bison bzip2 flex gawk gperf gzip help2man nano \ 
        perl patch tar texinfo unzip automake binutils build-essential cpio \ 
        libtool libncurses-dev pkg-config python-is-python3 libtool-bin premake bundler
ENV WORKDIR /mod/mod-plugin-builder/mod-workdir

# Build mod-host
RUN git clone https://github.com/moddevices/mod-plugin-builder.git --recursive /mod/mod-plugin-builder
RUN cd /mod/mod-plugin-builder && git submodule init && git submodule update
COPY ./copy_modguis.sh /mod/mod-plugin-builder 
RUN chmod +x /mod/mod-plugin-builder/copy_modguis.sh 
ARG PUID=$PUID
ARG PGID=$PGID

RUN cd /mod/mod-plugin-builder && mkdir mod-workdir && chown abc mod-workdir \
    && gosu ${PUID} ./bootstrap.sh x86_64 \
    && for i in `ls plugins/package |egrep -v 'max-gen|fluidplug|zynaddsubfx|pdlv2-labs|zeroconvo'` ; do gosu ${PUID} ./build x86_64 $i ; done \
    && cp -rfp mod-workdir/x86_64/plugins/* /usr/lib/lv2/ \
    && bash -c  '/mod/mod-plugin-builder/copy_modguis.sh' && echo && cd / && rm -rf /mod/mod-plugin-builder 

CMD echo "Plugin compiled and copied to /usr/lib/lv2" >> /mod/plugin.out

