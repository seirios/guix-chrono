# Guix packages for projectCHRONO

This repository is a Guix channel providing the following packages:

+ `projectCHRONO` with modules enabled:
  + `HDF5`
  + `FSI_SPH`
  + `MULTICORE`
  + `POSTPROCESS`
  + `VEHICLE`

+ `projectCHRONO-sensor` with all modules in `projectChrono` plus:
  + `IRRLICHT`
  + `SENSOR`

+ `projectCHRONO-vsg` with all modules in `projectCHRONO-sensor` plus:
  + `VSG`

+ `projectCHRONO-mkl` with all modules in `projectCHRONO` plus:
  + `PARDISO_MKL`

The dependencies for module `VSG` are also defined as packages.
The dependency NVIDIA OptiX for module `SENSOR` is also defined as a package.
