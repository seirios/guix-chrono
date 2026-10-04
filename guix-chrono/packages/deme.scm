(define-module (guix-chrono packages deme)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system cmake)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix-science-nonfree packages cuda)
  #:use-module (gnu packages gl))

(define-public deme
  (package
   (name "DEM-Engine")
   (version "3.0.14")
   (source (origin
	    (method git-fetch)
	    (uri (git-reference
		  (url "https://github.com/projectchrono/DEM-Engine")
		  (commit "e392442b960fcc4bd5d24843657be3f9c9279acf")
                  (recursive? #t)))
	    (file-name (git-file-name name version))
	    (sha256
	     (base32 "1x3r6i2yxijh0kl8x564j76s539rk2k5r60vhlgc7g8z8p4c8c6w"))))
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
         "-DDEME_BUILD_DEMOS=OFF"
         "-DDEME_BUILD_VISUALIZER=ON")))
   (native-inputs (list glfw))
   (inputs (list cuda-12.9))
   (propagated-inputs (list ))
   (home-page "https://github.com/projectchrono/DEM-Engine")
   (synopsis "SBEL Chrono DEM-Engine")
   (description "DEM-Engine (DEME) simulates granular materials using one or two NVIDIA GPUs.")
   (license license:bsd-3)))
