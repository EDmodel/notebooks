FROM edmodel/ed2:gnu-PR-357 as edmodel

FROM jupyter/base-notebook:latest
USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       libhdf5-openmpi-103 \
       libgomp1 \
       unzip \
       vim \
    && rm -rf /var/lib/apt/lists/*

# Copy the ed2 binary from the edmodel stage
COPY --from=edmodel /usr/bin/ed2 /usr/bin/ed2

USER jovyan

RUN pip install ipywidgets
RUN pip install paramiko
RUN pip install PyDrive


# Copy all .ipynb files from the current directory to /home/jovyan/ED
COPY --chown=jovyan:users *.ipynb /home/jovyan/
COPY --chown=jovyan:users ed-demo/ /home/jovyan/data/
RUN mkdir -p /home/jovyan/data/test-outputs/{tonzi,tonzi.harvest,umbs.bg}
#chmod 777 /home/jovyan/data
