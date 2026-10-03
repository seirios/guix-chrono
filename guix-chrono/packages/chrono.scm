(define-module (guix-chrono packages chrono)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system cmake)
  #:use-module (guix gexp)
  #:use-module ((guix licenses) #:prefix license:)
  ;; we define this because the substitute from guix-science has a bug
  #:use-module ((guix-chrono packages blaze) #:prefix chrono-blaze:)
  #:use-module (guix-chrono packages vsg)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages mpi)
  #:use-module (gnu packages pkg-config)
  #:use-module (guix-science packages algebra)
  #:use-module (guix-science-nonfree packages cuda))

(define-public chrono
  (package
   (name "projectCHRONO")
   (version "10.0.0")
   (source (origin
	    (method git-fetch)
	    (uri (git-reference
		  (url "https://github.com/projectchrono/chrono")
		  (commit version)))
	    (file-name (git-file-name name version))
	    (sha256
	     (base32 "0i4qz4cbgy8g9hkragpqhzqkk4waccrfzy6khs46hy2ll1yan2ps"))))
   (build-system cmake-build-system)
   (arguments
    (list
     ;; No tests defined, deactivate
     #:tests? #f
     ;; RUNPATH validation fails, since libcuda.so.1 is provided by NVIDIA driver
     #:validate-runpath? #f
     ;; Configuration flags
     #:configure-flags
     #~(list
	"-DBUILD_DEMOS=ON"
	"-DCH_ENABLE_HDF5=ON"
	"-DCH_ENABLE_MODULE_FSI=ON"
	"-DCH_ENABLE_MODULE_FSI_SPH=ON"
	"-DCH_ENABLE_MODULE_FSI_TDPF=OFF"
	"-DCH_ENABLE_MODULE_MULTICORE=ON"
	"-DCH_ENABLE_MODULE_POSTPROCESS=ON"
	"-DCH_ENABLE_MODULE_SENSOR=ON"
	"-DCH_ENABLE_MODULE_VEHICLE=ON")))
   (inputs (list chrono-blaze:blaze cuda-12.9 eigen-5 glew glfw hdf5 openblas openmpi))
   (home-page "https://projectchrono.org")
   (synopsis "ProjectCHRONO")
   (description "An Open Source Multi-physics Simulation Engine.")
   (license license:bsd-3)))

(define-public chrono-vsg
  (package
   (name "projectCHRONO-vsg")
   (version "10.0.0")
   (source (origin
	    (method git-fetch)
	    (uri (git-reference
		  (url "https://github.com/projectchrono/chrono")
		  (commit version)))
	    (file-name (git-file-name name version))
	    (sha256
	     (base32 "0i4qz4cbgy8g9hkragpqhzqkk4waccrfzy6khs46hy2ll1yan2ps"))))
   (build-system cmake-build-system)
   (arguments
    (list
     ;; No tests defined, deactivate
     #:tests? #f
     ;; RUNPATH validation fails, since libcuda.so.1 is provided by NVIDIA driver
     #:validate-runpath? #f
     ;; Configuration flags
     #:configure-flags
     #~(list
	"-DBUILD_DEMOS=ON"
	"-DCH_ENABLE_HDF5=ON"
	"-DCH_ENABLE_MODULE_FSI=ON"
	"-DCH_ENABLE_MODULE_FSI_SPH=ON"
	"-DCH_ENABLE_MODULE_FSI_TDPF=OFF"
	"-DCH_ENABLE_MODULE_MULTICORE=ON"
	"-DCH_ENABLE_MODULE_POSTPROCESS=ON"
	"-DCH_ENABLE_MODULE_SENSOR=ON"
	"-DCH_ENABLE_MODULE_VEHICLE=ON"
	"-DCH_ENABLE_MODULE_VSG=ON")))
   (native-inputs (list pkg-config))
   (inputs (list chrono-blaze:blaze cuda-12.9 eigen-5 glew glfw hdf5 openblas openmpi
                 vsg vsg-imgui vsg-xchange))
   (home-page "https://projectchrono.org")
   (synopsis "ProjectCHRONO (with VSG module)")
   (description "An Open Source Multi-physics Simulation Engine.")
   (license license:bsd-3)))
