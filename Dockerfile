FROM quay.io/jupyter/minimal-notebook:python-3.11

# Copy only environment.yml first so the slow install step is cached
# and only reruns when the environment changes
COPY --chown=${NB_UID}:${NB_GID} environment.yml /tmp/environment.yml

RUN mamba env create -f /tmp/environment.yml && \
    mamba clean --all -f -y && \
    /opt/conda/envs/holoccm/bin/python -m ipykernel install --user \
        --name holoccm --display-name "holoccm"

# Copy the repo into the home directory
COPY --chown=${NB_UID}:${NB_GID} . /home/jovyan/

WORKDIR /home/jovyan
