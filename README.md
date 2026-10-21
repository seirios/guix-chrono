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

+ `projectCHRONO-mumps` with all modules in `projectCHRONO` plus:
  + `MUMPS`

Dependencies for all modules not available elsewhere (or not in the required versions) are also defined as packages.
