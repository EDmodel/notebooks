## Model Overview

The Ecosystem Demography Biosphere Model (ED2) is an integrated terrestrial biosphere model incorporating hydrology, land-surface biophysics, vegetation dynamics, and soil carbon and nitrogen biogeochemistry ([Longo et al. 2019](https://dx.doi.org/10.5194/gmd-12-4309-2019);[Medvigy et al., 2009](https://dx.doi.org/10.1029/2008JG000812)). Like its predecessor, ED ([Moorcroft et al., 2001](https://dx.doi.org/10.1890/0012-9615(2001)071[0557:AMFSVD]2.0.CO;2)), ED2 uses a set of size- and age-structured partial differential equations that track the changing structure and composition of the plant canopy. With the ED2 model, in contrast to conventional biosphere models in which ecosystems with climatological grid cells are represented in a highly aggregated manner, the state of the aboveground ecosystem is described by the density of trees of different sizes and how this varies across horizontal space for a series of plant functional types. This more detailed description of ecosystem composition and structure enables the ED2 model to make realistic projections of both the fast-timescale exchanges of carbon, water and energy between the land and atmosphere, and long-term vegetation dynamics incorporating effects of ecosystem heterogeneity, including disturbance history and recovery.

## Jupyter Notebooks

This repository contains two jupyter notebooks that can be used to run the ED2 model. The first notebook can be used to run the model, the second notebook will check to see if the model is finished and show the outeput. You can run this locally on [docker](docker.md). There are containers for both X86 and ARM processors. To start the containers use the command below. This will print out a url (http://127.0.0.1:8888/lab?token=longstring) that can be used to connect to the jupyter notebook. The command will mount your current folder into the container as the `work` folder in your home directory.

```bash
docker run -ti --rm -p 8888:8888 -v ${PWD}:/home/jovyan/work ncsa/jupyter-ed
```

The jupyter notebook will have the ED2 binary installed in /usr/bin/ed2 so you can also use this to run your models in the container. To upload data simply drag and drop it on the file list on the left side.
