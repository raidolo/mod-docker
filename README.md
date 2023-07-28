# MOD Software 2023 version

I've forked this code from the very good work made by Alexis Boni in his [mod-docker](https://github.com/ajboni/mod-docker) implementation
His code was running an old version of the mod-ui interface. 
I made all the changes to build the current MOD software, taken from the [MOD GitHub](https://github.com/moddevices)
I did this basically because Mike Oliphant has released a [Neural Amp Modeler LV2 plugin](https://github.com/mikeoliphant/neural-amp-modeler-lv2) and I wanted to have a nice a powerful LV2 host to play with Linux. 
MOD Devices also made a mod-live-usb ISO to boot an x86 PC with their software, but it's difficult to use and booting from USB would not be ideal.

Additionally, I also built all the current MOD Plugins available in the [mod-plugin-builder repo](https://github.com/moddevices/mod-plugin-builder) so not only you have the free LV2 plugins that Alexis included in his version of mod-docker, but at the end the host will offer nearly 1000 LV2 plugins :)  

Another nice additional touch, I've also added the [browsepy File manager](https://github.com/moddevices/browsepy) so you can upload files directly from the MOD UI we interface. 

# Prebuilt Image on Docker Hub

This repo contains all the code to build the docker containers yourself, but because it can take a lot of time I also made a docker prebuilt image available here: [raidolo/mod-ui](https://hub.docker.com/r/raidolo/mod-ui) on Docker Hub

# mod-docker

MOD-DOCKER is an open-source [MOD Software](https://www.moddevices.com/) emulator for Linux based on Docker that lets you play around with hundreds of LV2 audio plugins!
This project aims to provide a docker container in order to use mod-host and mod-ui painlessly from your linux machine.

MOD team has done a remarkable job for the whole Linux audio open-source community, so if you like this emulator you should go get the real thing!

This project is heavily inspired in [MODEP](https://github.com/BlokasLabs/modep)

# REQUIREMENTS

You need to be have docker installed, docker-compose, JACK audio server should run at the HOST level, it should be installed in your linux Distro and already running before starting the container, aldo your user should be part of "audio" group.

The run scripts available in thie repo make three directories in yout $HOME folder, then the docker compose bind these local dire in the container, this is needed for the browsepy file manager and to store your files permanently in your home folder.

The directory that will be made are:
$HOME/mod-user-files
$HOME/mod-data
$HOME/mod-pedalboards


# USAGE to BUILD everything

*WARNING* It could a long time to compile 

- Clone the repo `git clone https://github.com/raidolo/mod-docker.git`
- `chmod +x run_build.sh`
- `./run_build.sh`
- go to `http://localhost:8888` and start playing!

# USAGE to DOWNLOAD the prebuilt Docker Image

- Clone the repo `git clone https://github.com/raidolo/mod-docker.git`
- chmod +x run_docker.sh
- ./run_docker.sh 
- go to `http://localhost:8888` and start playing!

# TODO / GOTCHAS

Currently the builder uses the kxrepos plugins and the mod-plugin-builder plugins

Also some plugins does not provide modguis so thy will be 'ugly'. Also some might not even work.

At the moment the container is just one, because it contains everything needed to run, I didn't have time to understant why in the original version of Alexis Bonis he was not able to run mod-host in a separate container, if it will be needed I'll investigate it.


![image](https://github.com/raidolo/mod-docker/assets/25846804/3abe0c9c-38ab-4edd-8463-d61a40f29fbd)

