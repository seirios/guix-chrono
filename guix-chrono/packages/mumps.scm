(define-module (guix-chrono packages mumps)
  #:use-module (guix gexp)
  #:use-module (guix utils)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system cmake)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages gcc)
  #:use-module ((gnu packages maths) #:prefix maths:))

(define-public metis
  (package
   (name "metis")
   (version "5.2.1.4")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/scivision/metis")
           (commit (string-append "v" version))))
     (file-name (git-file-name name version))
     (sha256
      (base32 "1xmm3qlms5rbyjjqsdy83rb0l5fxh1cmkxqzzaap5pjh78abpl00"))
     (modules '((guix build utils)))
     (snippet
      '(substitute* "CMakeLists.txt"
		    (("^set\\(gklib_url .*" line)
		     (string-append "if(NOT DEFINED gklib_url)\n" line
				    "endif()\n"))))
     ))
   (build-system cmake-build-system)
   (arguments
    (list
     #:tests? #f
     #:build-type "Release"
     #:configure-flags
     #~(list
        "-DBUILD_SHARED_LIBS=ON"
        (string-append "-Dgklib_url="
		       (assoc-ref %build-inputs "gklib-tarball")))))
   (inputs `(("gklib-tarball",
              (origin
               (method url-fetch)
               (uri "https://github.com/scivision/GKlib/archive/b4c45d104d421d3adb85fb900ca240eba781c95f.tar.gz")
               (sha256
                (base32
                 "0sxyr97azi15hscpl3jih0zgzsksdj8r0q84arid2ibk2d4msg05"))))))
   (home-page "http://glaros.dtc.umn.edu/gkhome/metis/metis/overview")
   (synopsis
    "Graph partitioning and fill-reducing matrix ordering library")
   (description
    "METIS is a set of serial programs for partitioning graphs, partitioning
finite element meshes, and producing fill-reducing orderings for sparse
matrices.  The algorithms implemented in METIS are based on the multilevel
recursive-bisection, multilevel k-way, and multi-constraint partitioning
schemes.")
   (license license:asl2.0)))          ;As of version 5.0.3


(define-public mumps
  (package
   (name "mumps")
   (version "5.9.1.2")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/scivision/mumps-superbuild")
           (commit (string-append "v" version))))
     (file-name (git-file-name name version))
     (sha256
      (base32 "0z9g8waypafrf47r8ghm0g9skbdq523gj1srxjwrcnd79mbvjqpb"))
     (modules '((guix build utils)))
     (snippet
      '(substitute* "CMakeLists.txt"
		    (("mumps_metis") "METIS")))
     ))
   (build-system cmake-build-system)
   (arguments
    (list
     #:tests? #f
     #:build-type "Release"
     #:configure-flags
     #~(list
        "-DBUILD_SINGLE=ON"
        "-DBUILD_DOUBLE=ON"
        "-DBUILD_SHARED_LIBS=ON"
        "-DMUMPS_openmp=ON"
        "-DMUMPS_parallel=OFF"
        "-DMUMPS_metis=ON"
        "-DMUMPS_scotch=ON"
        (string-append "-DMUMPS_url="
		       (assoc-ref %build-inputs "mumps-tarball")))))
   (inputs `(("gfortran" ,gfortran)
             ("openblas" ,maths:openblas)
             ("lapack" ,maths:lapack)
             ("metis" ,metis)
             ("scotch" ,maths:scotch)
             ("mumps-tarball",
              (origin
               (method url-fetch)
               (uri (string-append "https://mumps-solver.org/MUMPS_"
                                   (string-drop-right version 2) ".tar.gz"))
               (sha256
                (base32
                 "0ihv7q05hwdwrjm3savkdkj4886xz7xa3fhqqqx00nkbcibrp735"))))))
   (home-page "https://mumps-solver.org")
   (synopsis "Multifrontal sparse direct solver")
   (description
    "MUMPS (MUltifrontal Massively Parallel sparse direct Solver) solves a
sparse system of linear equations A x = b using Gaussian elimination.")
   (license license:cecill-c)))
