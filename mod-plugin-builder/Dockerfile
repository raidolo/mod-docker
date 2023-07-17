FROM mod-host
ENV REBUILD=true
ENV DEBIAN_FRONTEND=noninteractive

# Install dependemcies
RUN apt-get update && apt-get install -q -y acl bc curl cvs git mercurial \
        rsync subversion wget bison bzip2 flex gawk gperf gzip help2man nano \ 
        perl patch tar texinfo unzip automake binutils build-essential cpio \ 
        libtool libncurses-dev pkg-config python-is-python3 libtool-bin premake bundler
ENV WORKDIR /mod/mod-plugin-builder/mod-workdir

# Build mod-host
RUN git clone https://github.com/moddevices/mod-plugin-builder.git --recursive /mod/mod-plugin-builder
RUN cd /mod/mod-plugin-builder && git submodule init && git submodule update
ARG USERNAME $USER_NAME
ARG USERID $USER_ID
ARG GROUPID $GROUP_ID
RUN groupadd -f $GROUPID && useradd -m -g $GROUPID -G audio -u $USERID $USERNAME || true && cd /mod/mod-plugin-builder && mkdir mod-workdir && chown $USERNAME mod-workdir && gosu $USERNAME ./bootstrap.sh x86_64
RUN cd /mod/mod-plugin-builder && for i in `ls plugins/package |egrep -v 'max-gen|fluidplug|zynaddsubfx|pdlv2-labs|zeroconvo'` ; do gosu $USERNAME ./build x86_64 $i ; done 
RUN cd /mod/mod-plugin-builder && cp -rfp mod-workdir/x86_64/plugins/* /usr/lib/lv2/

RUN echo
COPY ./copy_modguis.sh /mod/mod-plugin-builder
RUN chmod +x /mod/mod-plugin-builder/copy_modguis.sh && bash -c  '/mod/mod-plugin-builder/copy_modguis.sh' && echo

RUN rm -rf /mod/mod-plugin-builder



CMD echo "Plugin compiled and copied to /usr/lib/lv2" >> /mod/plugin.out
