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

(define-public rust-fontdb-0.23
  (package
    (name "rust-fontdb")
    (version "0.23.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "fontdb" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1c7p94qf8x6n62nrbia7nzwdxm2sbyygnhd5qfmfl7p7h30p4dpc"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs
       (list (("rust-fontconfig-parser" ,rust-fontconfig-parser-0.5)
              ("rust-log" ,rust-log-0.4)
              ("rust-memmap2" ,rust-memmap2-0.9)
              ("rust-slotmap" ,rust-slotmap-0.5)
              ("rust-tinyvec" ,rust-tinyvec-1)
              ("rust-ttf-parser" ,rust-ttf-parser-0.25)
              ("rust-env-logger" ,rust-env-logger-0.10)
              ))))
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
     (list
      #:cargo-inputs
      (list rust-ab-glyph-0.2
            rust-clap-4
            rust-crossterm-0.27
            rust-env-logger-0.11)))
    ;; (native-inputs (list))
    ;; (inputs (list ))
    (home-page "https://github.com/7sDream/fontfor")
    (synopsis "Find and preview fonts that support a specified character")
    (description "FontFor is a tool for finding fonts that can display a given
character and previewing them.  The tool loads font files quickly
using mmap and only parses necessary font tables. It supports previews both in
the terminal and in a web browser for user-friendly font exploration.")  (license
license:gpl3+)))
