FROM awesomebytes/pepper_os_image_melodic:latest


USER nao
WORKDIR /data/home/nao


ADD --chown=nao:nao scripts /data/home/nao/scripts
ADD --chown=nao:nao shell /data/home/nao/shell
ADD --chown=nao:nao repos /data/home/nao/repos

COPY scripts/maqui_* /home/nao/

RUN export DOCKER_FLAG=1 && bash maqui_install.sh

COPY scripts/tensorflow_upg.sh /home/nao/
RUN bash tensorflow_upg.sh

COPY scripts/pytorch_installer.sh /home/nao/
RUN bash pytorch_installer.sh

# SHELL 
RUN mv shell/uchile.sh . &&\
    mv shell/maqui-bash_profile.sh .bash_profile &&\
    mv shell/uchile-shell .shell
 
# Cleaning Up
RUN rm -rf maqui_*.sh pytorch_installer.sh tensorflow_upg.sh
RUN rm -r repos shell scripts