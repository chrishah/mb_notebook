FROM jupyter/base-notebook

USER root

RUN apt-get update && apt-get install -y git
RUN git clone https://github.com/chrishah/MITObim.git && \
chown -R jovyan:users MITObim/ && \
mv MITObim/MITObim.pl MITObim/misc_scripts/* /usr/local/bin/ && \
rm -rf MITObim/
RUN wget https://sourceforge.net/projects/mira-assembler/files/MIRA/stable/mira_4.0.2_linux-gnu_x86_64_static.tar.bz2 && \
bzip2 -d mira_4.0.2_linux-gnu_x86_64_static.tar.bz2 && \
tar xvf mira_4.0.2_linux-gnu_x86_64_static.tar && \
chown jovyan:users mira_4.0.2_linux-gnu_x86_64_static/bin/mira* \
&& mv mira_4.0.2_linux-gnu_x86_64_static/bin/mira* /usr/local/bin/ && \
rm -rf mira_4.0.2_linux-gnu_x86_64_static* 

RUN git clone --recursive https://github.com/jupyter/docker-stacks.git && \
cp docker-stacks/base-notebook/start.sh docker-stacks/base-notebook/start-notebook.sh docker-stacks/base-notebook/start-singleuser.sh /usr/local/bin/ && \
cp docker-stacks/base-notebook/jupyter_notebook_config.py /etc/jupyter/ && \
docker-stacks/base-notebook/fix-permissions /etc/jupyter/ && \
rm -rf docker-stacks/

EXPOSE 8888
WORKDIR $HOME

# Configure container startup
ENTRYPOINT ["tini", "--"]
CMD ["start-notebook.sh"]

# Switch back to jovyan to avoid accidental container runs as root
USER $NB_USER
