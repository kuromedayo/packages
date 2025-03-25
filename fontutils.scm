(define-module (fontutils)
  #:use-module (gnu packages)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages bison)
  #:use-module (gnu packages check)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages datastructures)
  #:use-module (gnu packages docbook)
  #:use-module (gnu packages flex)
  #:use-module (gnu packages fonts)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages fribidi)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages ghostscript)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages gperf)
  #:use-module (gnu packages graphics)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages image)
  #:use-module (gnu packages java)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages man)
  #:use-module (gnu packages mc)
  #:use-module (gnu packages ninja)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-build)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages qt)
  #:use-module (gnu packages sqlite)
  #:use-module (gnu packages webkit)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages tex)
  #:use-module (gnu packages textutils)
  #:use-module (gnu packages crates-io)
  #:use-module (gnu packages crates-check)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix svn-download)
  #:use-module (guix git-download)
  #:use-module (guix build-system copy)
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system meson)
  #:use-module (guix build-system pyproject)
  #:use-module (guix build-system python)
  #:use-module (guix build-system cargo)
  #:use-module (guix utils)
  #:use-module (srfi srfi-1))

(define-public rust-fontconfig-parser-0.5
  (package
    (name "rust-fontconfig-parser")
    (version "0.5.7")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "fontconfig-parser" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "19xdfsvl9sjha9n1lk3s6bqixcihsmjsd7zf3y90rsd69kagrz61"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs
       (("rust-log" ,rust-log-0.4)
        ("rust-roxmltree" ,rust-roxmltree-0.20)
        ("rust-serde" ,rust-serde-1)
        ("rust-criterion" ,rust-criterion-0.5)
        ("rust-glob" ,rust-glob-0.3)
        ("rust-k9" ,rust-k9-0.12)
        ("rust-serde-json" ,rust-serde-json-1))))
    (home-page "https://github.com/fschutt/rust-fontconfig")
    (synopsis "Pure-Rust rewrite of the Linux fontconfig library")
    (description "This package provides a Pure-Rust implementation of the Linux fontconfig library, with no system dependencies. It uses the @package{ttf-parser} and @package{allsorts} crates for font parsing and handling.")
    (license license:expat)))

(define-public rust-ttf-parser-0.20
  (package
    (inherit rust-ttf-parser-0.25)
    (name "rust-ttf-parser")
    (version "0.20.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "ttf-parser" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1d4n3p9ccjvy4mj72700i0c2q6d49dxjpwflw47q79rpv1v7vxqp"))))
    (arguments
     `(#:skip-build? #t)))) ; Cut the dependency graph.

(define-public rust-fontdb-0.16
  (package
    (name "rust-fontdb")
    (version "0.16.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "fontdb" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "19l8w3817j4pz78zz60hfivn6nhi62427i6j5lszf1w4lda8rf4q"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs
       (("rust-fontconfig-parser" ,rust-fontconfig-parser-0.5)
        ("rust-log" ,rust-log-0.4)
        ("rust-memmap2" ,rust-memmap2-0.9)
        ("rust-slotmap" ,rust-slotmap-1)
        ("rust-tinyvec" ,rust-tinyvec-1)
        ("rust-ttf-parser" ,rust-ttf-parser-0.20)
        ("rust-env-logger" ,rust-env-logger-0.10))))
    (home-page "https://github.com/alexheretic/ab-glyph")
    (synopsis "In-memory font database with CSS-like queries")
    (description "This package provides an in-memory font database that supports
 loading fonts from files, directories, and raw data. It allows querying of
 fonts using CSS-like queries and includes functionality for loading system
 fonts by scanning predefined directories. Each font face is assigned a unique
 ID.")
    (license license:expat)))

(define-public rust-wit-bindgen-rt-0.39
  (package
    (name "rust-wit-bindgen-rt")
    (version "0.39.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wasi" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "08z4hxwkpdpalxjps1ai9y7ihin26y9f476i53dv98v45gkqg3cw"))))
    (build-system cargo-build-system)
    (arguments
     (list #:cargo-inputs
           `(("rust-bitflags" ,rust-bitflags-2)
             ("rust-futures" ,rust-futures-0.3)
             ("rust-once-sell" ,rust-once-cell-1))))
    (home-page "https://github.com/bytecodealliance/wasi")
    (synopsis "Runtime support for wit-bindgen bindings")
    (description "This package provides runtime support for wit-bindgen, a suite
 of bindings generators for languages compiled to WebAssembly using the
 component model. It facilitates the use of bindings described in *.wit files,
 managing imports, exports, and reuse between bindings definitions.")
    (license (list license:asl2.0 license:expat))))

(define-public rust-wasi-0.14
  (package
    (name "rust-wasi")
    (version "0.14.2+wasi-0.2.4")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wasi" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1cwcqjr3dgdq8j325awgk8a715h0hg0f7jqzsb077n4qm6jzk0wn"))))
    (build-system cargo-build-system)
    (arguments
     (list #:skip-build? #t
           #:cargo-inputs
           `(("rust-compiler-builtins" ,rust-compiler-builtins-0.1)
             ("rust-rustc-std-workspace-alloc"
              ,rust-rustc-std-workspace-alloc-1)
             ("rust-rustc-std-workspace-core"
              ,rust-rustc-std-workspace-core-1)
             ("rust-compiler-builtins" ,rust-compiler-builtins-0.1)
             ("rust-wit-bindgen-rt" ,rust-wit-bindgen-rt-0.39))))
    (home-page "https://github.com/bytecodealliance/wasi")
    (synopsis "Experimental WASI API bindings for Rust")
    (description
     "This package provides experimental WASI API bindings for Rust.")
    (license (list license:asl2.0
                   license:expat))))

(define-public rust-getrandom-0.3
  (package
    (name "rust-getrandom")
    (version "0.3.2")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "getrandom" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1mzlnrb3dgyd1fb84gvw10pyr8wdqdl4ry4sr64i1s8an66pqmn4"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs
       (("rust-cfg-if" ,rust-cfg-if-1)
        ("rust-compiler-builtins" ,rust-compiler-builtins-0.1)
        ("rust-js-sys" ,rust-js-sys-0.3)
        ("rust-libc" ,rust-libc-0.2)
        ("rust-rustc-std-workspace-core" ,rust-rustc-std-workspace-core-1)
        ("rust-wasi" ,rust-wasi-0.14)
        ("rust-wasm-bindgen" ,rust-wasm-bindgen-0.2))
       #:cargo-development-inputs
       (("rust-wasm-bindgen-test" ,rust-wasm-bindgen-test-0.3))))
    (home-page "https://github.com/rust-random/getrandom")
    (synopsis "Retrieve random data from system source")
    (description
     "This package provides a small cross-platform library for
retrieving random data from system source.")
    (license (list license:expat license:asl2.0))))

(define-public rust-rand-core-0.9
  (package
    (name "rust-rand-core")
    (version "0.9.3")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "rand_core" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0b4j2v4cb5krak1pv6kakv4sz6xcwbrmy2zckc32hsigbrwy82zc"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs
       (("rust-getrandom" ,rust-getrandom-0.2)
        ("rust-serde" ,rust-serde-1))))
    (home-page "https://rust-random.github.io/book")
    (synopsis "Core random number generator traits and tools")
    (description
     "This package provides core random number generator traits and
tools for implementation.")
    (license (list license:expat license:asl2.0))))

(define-public rust-rand-chacha-0.9
  (package
    (name "rust-rand-chacha")
    (version "0.9.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "rand_chacha" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "123x2adin558xbhvqb8w4f6syjsdkmqff8cxwhmjacpsl1ihmhg6"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs
       (("rust-ppv-lite86" ,rust-ppv-lite86-0.2)
        ("rust-rand-core" ,rust-rand-core-0.6)
        ("rust-serde" ,rust-serde-1))
       #:cargo-development-inputs
       (("rust-serde-json" ,rust-serde-json-1))))
    (home-page "https://crates.io/crates/rand_chacha")
    (synopsis "ChaCha random number generator")
    (description
     "This package provides the ChaCha random number generator.")
    (license (list license:expat license:asl2.0))))

(define-public rust-rand-0.9
  (package
    (name "rust-rand")
    (version "0.9.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "rand" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "013l6931nn7gkc23jz5mm3qdhf93jjf0fg64nz2lp4i51qd8vbrl"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs
       (("rust-log" ,rust-log-0.4)
        ("rust-rand-chacha" ,rust-rand-chacha-0.9)
        ("rust-libc" ,rust-libc-0.2)
        ("rust-log" ,rust-log-0.4)
        ("rust-packed-simd-2" ,rust-packed-simd-2-0.3)
        ("rust-rand-core" ,rust-rand-core-0.6)
        ("rust-serde" ,rust-serde-1))
       #:cargo-development-inputs
       (("rust-bincode" ,rust-bincode-1)
        ("rust-rand-pcg" ,rust-rand-pcg-0.3))))
    (home-page "https://crates.io/crates/rand")
    (synopsis "Random number generators and other randomness functionality")
    (description
     "Rand provides utilities to generate random numbers, to convert them to
useful types and distributions, and some randomness-related algorithms.")
    (license (list license:expat license:asl2.0))))

(define-public rust-grid-0.16
  (package
    (name "rust-grid")
    (version "0.16.1")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "grid" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "19l8w3817j4pz78zz60hfivn6nhi62427i6j5lszf1w4lda8rf4q"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs
       (("rust-serde" ,rust-serde-1)
        ("rust-criterion" ,rust-criterion-0.5)
        ("rust-rand" ,rust-rand-)
        ("rust-env-logger" ,rust-env-logger-0.10))))
    (home-page "https://github.com/alexheretic/ab-glyph")
    (synopsis "In-memory font database with CSS-like queries")
    (description "This package provides an in-memory font database that supports
 loading fonts from files, directories, and raw data. It allows querying of
 fonts using CSS-like queries and includes functionality for loading system
 fonts by scanning predefined directories. Each font face is assigned a unique
 ID.")
    (license license:expat)))

(define-public my-fontfor
  (package
    (name "my-fontfor")
    (version "0.4.3")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/7sDream/fontfor")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "13v9b2w94fqixy7v6nvzm35ran27smiw28x2rh2ycagzy947v6c0"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs
       (("rust-ab-glyph" ,rust-ab-glyph-0.2)
        ("rust-clap" ,rust-clap-4)
        ("rust-crossterm" ,rust-crossterm-0.27)
        ("rust-env-logger" ,rust-env-logger-0.11)
        ("rust-fontdb" ,rust-fontdb-0.16)
        ("rust-clap" ,rust-clap-4)
        ("rust-clap" ,rust-clap-4)
        ("rust-clap" ,rust-clap-4)
        ("rust-clap" ,rust-clap-4)
        ("rust-clap" ,rust-clap-4)
        ("rust-clap" ,rust-clap-4)
        )))
    ;; (native-inputs (list))
    ;; (inputs (list ))
    (home-page "https://github.com/7sDream/fontfor")
    (synopsis "Find and preview fonts that support a specified character")
    (description "FontFor is a tool for finding fonts that can display a given
character and previewing them.  The tool loads font files quickly
using mmap and only parses necessary font tables. It supports previews both in
the terminal and in a web browser for user-friendly font exploration.")  (license
license:gpl3+)))
