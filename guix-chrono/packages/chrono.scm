(define-module (guix-chrono packages chrono)
  #:use-module (guix gexp)
  #:use-module (guix utils)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system cmake)
  #:use-module ((guix licenses) #:prefix license:)
  ;; we define this because the substitute from guix-science has a bug
  #:use-module ((guix-chrono packages blaze) #:prefix chrono-blaze:)
  #:use-module (guix-chrono packages vsg)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages mpi)
  #:use-module (gnu packages pkg-config)
  #:use-module (guix-science packages algebra)
  #:use-module (guix-science-nonfree packages cuda)
  #:use-module (guix-science-nonfree packages mkl))

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
     ;; Build type: Release
     #:build-type "Release"
     ;; Configuration flags
     #:configure-flags
     #~(list
	"-DBUILD_DEMOS=OFF"
	"-DCH_ENABLE_HDF5=ON"
	"-DCH_ENABLE_MODULE_FSI=ON"
	"-DCH_ENABLE_MODULE_FSI_SPH=ON"
	"-DCH_ENABLE_MODULE_FSI_TDPF=OFF"
	"-DCH_ENABLE_MODULE_MULTICORE=ON"
	"-DCH_ENABLE_MODULE_POSTPROCESS=ON"
	"-DCH_ENABLE_MODULE_VEHICLE=ON")))
   (inputs (list chrono-blaze:blaze cuda-12.9 eigen-5 openmpi))
   (propagated-inputs (list hdf5 openblas))
   (home-page "https://projectchrono.org")
   (synopsis "ProjectCHRONO")
   (description "An Open Source Multi-physics Simulation Engine.")
   (license license:bsd-3)))

(define-public chrono-mkl
  (package/inherit chrono
		   (name "projectCHRONO-mkl")
		   (arguments
		    (substitute-keyword-arguments (package-arguments chrono)
						  ((#:configure-flags flags #~(list))
						   #~(append #$flags (list
								      "-DCH_ENABLE_MODULE_PARDISO_MKL=ON"
                                                                      "-DMKL_THREADING=gnu_thread")))))
		   (propagated-inputs (modify-inputs (package-propagated-inputs chrono)
						     (append mkl-2023)))))

(define-public chrono-sensor
  (package/inherit chrono
		   (name "projectCHRONO-sensor")
		   (arguments
		    (substitute-keyword-arguments (package-arguments chrono)
						  ((#:configure-flags flags #~(list))
						   #~(append #$flags (list "-DCH_ENABLE_MODULE_SENSOR=ON")))))
		   (inputs (modify-inputs (package-inputs chrono) (append glew glfw)))))

(define-public chrono-vsg
  (package/inherit chrono
		   (name "projectCHRONO-vsg")
		   (arguments
		    (substitute-keyword-arguments (package-arguments chrono)
						  ((#:configure-flags flags #~(list))
						   #~(append #$flags (list
								      "-DCH_ENABLE_MODULE_SENSOR=ON"
								      "-DCH_ENABLE_MODULE_VSG=ON")))))
		   (inputs (modify-inputs (package-inputs chrono) (append glew glfw)))
		   (propagated-inputs (modify-inputs (package-propagated-inputs chrono)
						     (append vsg vsg-imgui vsg-exchange)))))
