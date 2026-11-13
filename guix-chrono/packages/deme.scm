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
   (version "3.0.19")
   (source (origin
	    (method git-fetch)
	    (uri (git-reference
		  (url "https://github.com/projectchrono/DEM-Engine")
		  (commit "6875eb98c6e33beedcd0f1cf8c0a0e5cbbd98efe")
                  (recursive? #t)))
	    (file-name (git-file-name name version))
	    (sha256
	     (base32
	      "10h8w40w3prs99pmyibxzs6azfkgwqjyggn8pd93v5r3lc03jmph"))))
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
   (description
    "DEM-Engine (DEME) simulates granular materials using one or two NVIDIA GPUs.")
   (license license:bsd-3)))


(define-public deme-v2
  (package
   (name "DEM-Engine-v2")
   (version "2.4.2")
   (source (origin
	    (method git-fetch)
	    (uri (git-reference
		  (url "https://github.com/projectchrono/DEM-Engine")
		  (commit (string-append "v" version))
                  (recursive? #t)))
	    (file-name (git-file-name name version))
	    (sha256
	     (base32
	      "01bpk3xb5xfisqpgziy5025pp1kqw2sq3r87g2pfbzq8xamnzk3g"))))
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
   (description
    "DEM-Engine (DEME) simulates granular materials using one or two NVIDIA GPUs.")
   (license license:bsd-3)))
