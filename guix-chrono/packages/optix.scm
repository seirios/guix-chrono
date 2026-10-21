(define-module (guix-chrono packages optix)
  #:use-module (guix gexp)
  #:use-module (guix utils)
  #:use-module (guix packages)
  #:use-module (guix build-system copy)
  #:use-module ((guix-science-nonfree licenses) #:prefix nonfree:))

(define-public nvidia-optix
  (package
   (name "nvidia-optix")
   (version "9.1.0")
   (build-system copy-build-system)
   (arguments
    (list
     #:install-plan
     `'(("doc" "/doc")
        ("include" "/include")
        ("lib64" "/lib64")
        ("SDK" "/SDK")
        ("license_info.txt" "/share/doc/nvidia-optix/")
        ("OptiX_EndUserLicense.pdf" "/share/doc/nvidia-optix/")
        ("OptiX_ThirdParty_Licenses.txt" "/share/doc/nvidia-optix/"))
     #:phases
     #~(modify-phases %standard-phases
                      (replace 'unpack
			       (lambda*
				   (#:key inputs #:allow-other-keys)
				 (let
				     ((source
				       (assoc-ref inputs "source")))
				   (invoke "sh" source
					   "--skip-license"
					   "--prefix=" #$output))))
                      (delete 'install-license-files))))
   (source
    (plain-file "provide_sources.sh"
		"#!/bin/sh\necho 'ERROR: Download source archive with an NVIDIA Developer Account and provide path to file using --with-source=nvidia-optix=<FILE>'\nexit 1\n"))
   (home-page "https://developer.nvidia.com/rtx/ray-tracing/optix")
   (synopsis "NVIDIA OptiX Ray Tracing Engine")
   (description
    "An application framework for achieving optimal ray tracing performance on the GPU. It provides a simple, recursive, and flexible pipeline for accelerating ray tracing algorithms. Bring the power of NVIDIA GPUs to your ray tracing applications with programmable intersection, ray generation, and shading.")
   (license
    (nonfree:nonfree
     "https://developer.nvidia.com/designworks/sdk-samples-tools-software-license-agreement"))))
