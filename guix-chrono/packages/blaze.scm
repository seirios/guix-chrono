(define-module (guix-chrono packages blaze)
  #:use-module (guix)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix build-system cmake)
  #:use-module (gnu packages)
  #:use-module (gnu packages maths))

(define-public blaze
  (package
    (name "blaze")
    (version "3.8.2")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://bitbucket.org/blaze-lib/blaze.git")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1sr4q4f2rwk6xafiyqz8rv4kcgggw1yka31aq08big41b9c5jpr6"))))
    (build-system cmake-build-system)
    (arguments
     (list
      #:configure-flags
      #~(list
         ;; Use automatic cache size.
         "-DBLAZE_CACHE_SIZE_AUTO=ON"
         ;; Enable acceleration through BLAS.
         "-DBLAZE_BLAS_MODE=ON")
      ;; TODO: Find a way to compile and run the test suite.
      #:tests? #f))
    (inputs (list openblas))
    (home-page "https://bitbucket.org/blaze-lib/blaze")
    (synopsis "High performance C++ math library")
    (description
     "Blaze is an open-source, high-performance C++ math library for dense and
sparse arithmetic.  With its state-of-the-art Smart Expression Template
implementation Blaze combines the elegance and ease of use of a domain-specific
language with HPC-grade performance, making it one of the most intuitive and
fastest C++ math libraries available.

The Blaze library offers:

@itemize
@item high performance through the integration of BLAS libraries and manually
tuned HPC math kernels;
@item vectorization by SSE, SSE2, SSE3, SSSE3, SSE4, AVX, AVX2, AVX-512, FMA,
SVML, SLEEF, and XSIMD;
@item parallel execution by OpenMP, HPX, C++11 threads and Boost threads;
@item an intuitive and easy to use API of a domain specific language;
@item unified arithmetic with dense and sparse vectors and matrices;
@item thoroughly tested matrix and vector arithmetic;
@item completely portable, high quality C++ source code.
@end itemize")
    (license license:bsd-3)))
