## Model Overview

The Ecosystem Demography Biosphere Model (ED2) is an integrated terrestrial biosphere model incorporating hydrology, land-surface biophysics, vegetation dynamics, and soil carbon and nitrogen biogeochemistry ([Longo et al. 2019](https://dx.doi.org/10.5194/gmd-12-4309-2019);[Medvigy et al., 2009](https://dx.doi.org/10.1029/2008JG000812)). Like its predecessor, ED ([Moorcroft et al., 2001](https://dx.doi.org/10.1890/0012-9615(2001)071[0557:AMFSVD]2.0.CO;2)), ED2 uses a set of size- and age-structured partial differential equations that track the changing structure and composition of the plant canopy. With the ED2 model, in contrast to conventional biosphere models in which ecosystems with climatological grid cells are represented in a highly aggregated manner, the state of the aboveground ecosystem is described by the density of trees of different sizes and how this varies across horizontal space for a series of plant functional types. This more detailed description of ecosystem composition and structure enables the ED2 model to make realistic projections of both the fast-timescale exchanges of carbon, water and energy between the land and atmosphere, and long-term vegetation dynamics incorporating effects of ecosystem heterogeneity, including disturbance history and recovery.

## Jupyter Notebooks

This repository contains two jupyter notebooks that can be used to run the ED2 model. The first notebook can be used to run the model, the second notebook will check to see if the model is finished and show the outeput. You can run this locally on [docker](docker.md). There are containers for both X86 and ARM processors. To start the containers use the command below. This will print out a url (http://127.0.0.1:8888/lab?token=longstring) that can be used to connect to the jupyter notebook. The command will mount your current folder into the container as the `work` folder in your home directory.

```bash
docker run -ti --rm -p 8888:8888 --ulimit stack=-1 -v ${PWD}:/home/jovyan/work ncsa/jupyter-ed
```

The jupyter notebook will have the ED2 binary installed in /usr/bin/ed2 so you can also use this to run your models in the container. To upload data simply drag and drop it on the file list on the left side.

## Apptainer

The notebook will let you submit jobs to different HPC clusters. On HPC centers we can not use docker due to various security issues (for example no root is allowed), an alternative was created called [apptainer](https://apptainer.org/) (formery known as singularity). To be able to use this on clusters you might have to load the appropriate module, either apptainer, or singularity. Once loaded (potentially by default) the command `apptainer` should work.

```bash
module load apptainer
```

To convert the [container for the ED2 model](https://hub.docker.com/r/edmodel/ed2) to be able to use with the HPC it needs to be converted to an apptainer file. This will download the container to your HPC cluster and convert it to a singularity file (sif file). You only have to do this once, if you want to get a newer version you will need to remove `ed2.sif` first and rerun the above command.

```bash
apptainer pull ed2.sif docker://edmodel/ed2:gnu
```

Now that you have the apptainer file, you can submit it as normal to your cluster using `sbatch` and an configuration file (an example is shown below). You will need to make sure apptainer again can be found, but no need to load any other modules, all needed libraries, etc are all encapsulated in the apptainer file.

```bash
#!/bin/bash
#SBATCH --account=bbwq-delta-cpu
#SBATCH --time=00:15:00
#SBATCH --ntasks-per-node=16
#SBATCH --job-name=ED2IN
#SBATCH --partition=cpu
#SBATCH --output=openmp_ED2IN.o%j
#SBATCH --error=openmp_ED2IN.e%j
#SBATCH --mail-user=svcecomodeluser@illinois.edu
#SBATCH --mail-type=BEGIN,END

mkdir -p demo
cd demo

ulimit -s unlimited
apptainer run --no-home --pwd /data \
    --bind ${HOME}/ed-demo:/data \
    --bind ${PWD}/demo:/data/outputs \
    ${HOME}/ed2.sif ed2 -f ED2IN-umbs.bg
```

In this case all the data is located in the `ed-demo` folder and in the ED2IN and `ED_MET_DRIVER_HEADER` we use the paths either relative to the `/data` folder, or it can be the absolute path starting at `/data` not the actual path on the HPC.

## Troubleshooting

If you try to run `ed2` and it results in a `Segmentation fault`, make sure you have `ulimit stack` set, either when you start it with docker, or in the shell when you art ed2

```bash
> ed2 -f ED2IN-tonzi
+---------------- MPI parallel info: --------------------+
+  - Machnum  =      0
...
|  Single process execution on INITIAL run.
+------------------------------------------------------------+
Segmentation fault (core dumped)


> ulimit -s unlimited
> ed2 -f ED2IN-tonzi
+---------------- MPI parallel info: --------------------+
+  - Machnum  =      0

```

