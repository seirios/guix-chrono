(define-module (guix-chrono packages vsg)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system cmake)
  #:use-module (guix gexp)
  #:use-module (guix utils)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages python)
  #:use-module ((gnu packages vulkan) #:prefix vulkan:)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages version-control))

(define-public vsg
  (package
   (name "VulkanSceneGraph")
   (version "1.1.11")
   (source (origin
	    (method git-fetch)
	    (uri (git-reference
		  (url "https://github.com/vsg-dev/VulkanSceneGraph")
		  (commit (string-append "v" version))))
	    (file-name (git-file-name name version))
	    (sha256
	     (base32 "051r6q221r0rc6av731hg3rxs5n4vj557fq4hpf3ffar0cg6qfd3"))))
   (build-system cmake-build-system)
   (arguments
    (list
     ;; No tests defined, deactivate
     #:tests? #f
     ;; Configuration flags
     #:configure-flags
     #~(list "")))
   (native-inputs (list pkg-config))
   (propagated-inputs (list glslang libxcb vulkan:vulkan-headers vulkan:vulkan-loader))
   (home-page "https://vulkanscenegraph.org")
   (synopsis "VulkanSceneGraph")
   (description "VulkanSceneGraph (VSG), is a modern, cross platform, high performance scene graph library built upon Vulkan graphics/compute API.")
   (license license:expat)))

(define-public vsg-xchange
  (package
   (name "vsgXchange")
   (version "1.1.7")
   (source (origin
	    (method git-fetch)
	    (uri (git-reference
		  (url "https://github.com/vsg-dev/vsgXchange")
		  (commit (string-append "v" version))))
	    (file-name (git-file-name name version))
	    (sha256
	     (base32 "1z8546qgv77f6mj2hhrzgyfl8qnjfl9dk20fa2j65zhqbnjpxvam"))))
   (build-system cmake-build-system)
   (arguments
    (list
     ;; No tests defined, deactivate
     #:tests? #f
     ;; Configuration flags
     #:configure-flags
     #~(list "")))
   (native-inputs (list pkg-config))
   (propagated-inputs (list assimp draco vsg))
   (home-page "https://github.com/vsg-dev/vsgXchange")
   (synopsis "vsgXchange")
   (description "Utility library for converting 3rd party images, models and fonts formats to/from VulkanSceneGraph.")
   (license license:expat)))

(define-public vsg-imgui
  (package
   (name "vsgImGui")
   (version "0.7.0")
   (source (origin
	    (method git-fetch)
	    (uri (git-reference
		  (url "https://github.com/vsg-dev/vsgImGui.git")
		  (commit (string-append "v" version)) (recursive? #t)))
	    (file-name (git-file-name name version))
	    (sha256
	     (base32 "02gfz2af20fw4lsdrd61b79f2d7p1mm1nnc3phhdaazaqjjd648r"))))
   (build-system cmake-build-system)
   (arguments
    (list
     ;; No tests defined, deactivate
     #:tests? #f
     ;; Configuration flags
     #:configure-flags
     #~(list "")))
   (native-inputs (list pkg-config))
   (propagated-inputs (list vsg))
   (home-page "https://github.com/vsg-dev/vsgImGui")
   (synopsis "vsgImGui")
   (description "Library that integrates VulkanSceneGraph with Dear ImGui and ImPlot.")
   (license license:expat)))

(define-public vsg-examples
  (package
   (name "vsgExamples")
   (version "1.1.9")
   (source (origin
	    (method git-fetch)
	    (uri (git-reference
		  (url "https://github.com/vsg-dev/vsgExamples")
		  (commit (string-append "v" version))))
	    (file-name (git-file-name name version))
	    (sha256
	     (base32 "13bzaq1kivk8m8asn4g9qka0zka0p2gymg1r54ka5gl82g5xgmi3"))))
   (build-system cmake-build-system)
   (arguments
    (list
     ;; No tests defined, deactivate
     #:tests? #f
     ;; Configuration flags
     #:configure-flags
     #~(list "")))
   (native-inputs (list pkg-config))
   (propagated-inputs (list vsg))
   (home-page "https://github.com/vsg-dev/vsgExamples")
   (synopsis "vsgExamples")
   (description "Example programs that test and illustrate how to use the VulkanSceneGraph and optional add-on libraries.")
   (license license:expat)))

(define-public assimp
  (package
   (name "assimp")
   (version "5.4.3")
   (source (origin
	    (method git-fetch)
	    (uri (git-reference
		  (url "https://github.com/assimp/assimp")
		  (commit (string-append "v" version))))
	    (file-name (git-file-name name version))
	    (sha256
	     (base32 "097fxq0frb2nl6bp8wz7kjx6vq4i4117wwq9fnxzkiij9xwv3cq9"))))
   (build-system cmake-build-system)
   (arguments
    (list
     ;; We disabled tests, deactivate
     #:tests? #f
     ;; Configuration flags
     #:configure-flags
     #~(list
         "-DASSIMP_BUILD_TESTS=OFF"
         "-DASSIMP_BUILD_ASSIMP_TOOLS=OFF"
         "-DASSIMP_BUILD_ZLIB=ON")))
   (home-page "https://github.com/assimp/assimp")
   (synopsis "Open Asset Import Library")
   (description "Open Asset Import Library is a library that loads various 3D file formats into a shared, in-memory format.")
   (license license:bsd-3)))

(define-public draco
  (package
   (name "draco")
   (version "1.5.7")
   (source (origin
	    (method git-fetch)
	    (uri (git-reference
		  (url "https://github.com/google/draco")
		  (commit version)))
	    (file-name (git-file-name name version))
	    (sha256
	     (base32 "1v1idvqr9mww9wi36yzb10lq66ls78dlrgnxchjjjv5paw2g0mk3"))))
   (build-system cmake-build-system)
   (arguments
    (list
     ;; No tests defined, deactivate
     #:tests? #f
     ;; Configuration flags
     #:configure-flags
     #~(list
         "-DBUILD_SHARED_LIBS=ON")))
   (home-page "https://github.com/google/draco")
   (synopsis "Draco")
   (description "Draco is a library for compressing and decompressing 3D geometric meshes and point clouds. It is intended to improve the storage and transmission of 3D graphics.")
   (license license:asl2.0)))

(define-public glslang
  (package
   (name "glslang")
   (version "15.4.0")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/KhronosGroup/glslang")
           (commit version)))
     (sha256
      (base32 "1b0zsrv12b34q0wp9g85x11kpd5kjvx4lbn7xv8b4szfpwdkxxxh"))
     (file-name (git-file-name name version))))
   (build-system cmake-build-system)
   (arguments
    (list
     #:configure-flags
     #~(list "-DBUILD_SHARED_LIBS=ON"
             "-DALLOW_EXTERNAL_SPIRV_TOOLS=ON"
             #$@(if (target-riscv64?)
                    `("-DCMAKE_EXE_LINKER_FLAGS=-latomic")
                    '()))
     #:phases
     #~(modify-phases %standard-phases
		      #$@(cond
			  ((target-arm32?)
			   `((add-after 'unpack 'skip-failing-test
					(lambda _
					  ;; TODO: Figure out why this test fails.
					  (substitute* "Test/runtests"
						       ((".*(single|multi)Thread" all)
							(string-append "echo " all)))))))
			  (#t '()))
		      (replace 'check
			       (lambda* (#:key tests? parallel-tests? #:allow-other-keys)
					(when tests?
					  (invoke "ctest"
						  "-j" (if parallel-tests?
							   (number->string (parallel-job-count))
							   "1")
						  "--rerun-failed"
						  "--output-on-failure")))))))
   ;; Propagate spirv-tools as its CMake module is a dependency of glslang's
   ;; own CMake module.
   (propagated-inputs (list spirv-tools))
   (native-inputs
    (list pkg-config python-minimal))
   (home-page "https://github.com/KhronosGroup/glslang")
   (synopsis "OpenGL and OpenGL ES shader front end and validator")
   (description
    "Glslang is the official reference compiler front end for the
OpenGL@tie{}ES and OpenGL shading languages.  It implements a strict
interpretation of the specifications for these languages.")
   ;; Modified BSD license. See "copyright" section of
   ;; https://www.khronos.org/opengles/sdk/tools/Reference-Compiler/
   (license (list license:bsd-3
                  ;; include/SPIRV/{bitutils,hex_float}.h are Apache 2.0.
                  license:asl2.0))))

(define-public spirv-headers
  (package
   (name "spirv-headers")
   ;; version tag from commit in glslang/known_good.json
   (version "1.4.321.0")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/KhronosGroup/SPIRV-Headers")
           (commit (string-append "vulkan-sdk-" version))))
     (sha256
      (base32 "11nsfr6z11dx6ccyi9anz2iycxr9i06zl8dk4pdllf3dvk5wq61d"))
     (file-name (git-file-name name version))))
   (build-system cmake-build-system)
   (arguments
    `(#:tests? #f))                    ;no tests
   (home-page "https://github.com/KhronosGroup/SPIRV-Headers")
   (synopsis "Machine-readable files from the SPIR-V Registry")
   (description
    "SPIRV-Headers is a repository containing machine-readable files from
the SPIR-V Registry.  This includes:
@itemize
@item Header files for various languages.
@item JSON files describing the grammar for the SPIR-V core instruction set,
and for the GLSL.std.450 extended instruction set.
@item The XML registry file.
@end itemize\n")
   (license (license:x11-style
             (string-append "https://github.com/KhronosGroup/SPIRV-Headers/blob/"
                            version "/LICENSE")))))

(define-public spirv-tools
  (package
   (name "spirv-tools")
   ;; version tag from commit in glslang/known_good.json
   (version "1.4.321.0")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/KhronosGroup/SPIRV-Tools")
           (commit (string-append "vulkan-sdk-" version))))
     (sha256
      (base32 "015xymrzch87f3xkzx9rvlglqp39zx4vphjb2dkl5w6qcpz5s1y8"))
     (file-name (git-file-name name version))))
   (build-system cmake-build-system)
   (arguments
    (list
     #:configure-flags
     #~(list "-DBUILD_SHARED_LIBS=ON"
             ;; Some packages like mpv fail to link
             ;; when the static libraries are built.
             "-DSPIRV_TOOLS_BUILD_STATIC=OFF"
             (string-append
              "-DSPIRV-Headers_SOURCE_DIR="
              (assoc-ref %build-inputs "spirv-headers")))))
   (inputs (list spirv-headers))
   (native-inputs (list pkg-config python-minimal))
   (home-page "https://github.com/KhronosGroup/SPIRV-Tools")
   (synopsis "API and commands for processing SPIR-V modules")
   (description
    "The SPIR-V Tools project provides an API and commands for processing
SPIR-V modules.  The project includes an assembler, binary module
parser,disassembler, validator, and optimizer for SPIR-V.")
   (license license:asl2.0)))
