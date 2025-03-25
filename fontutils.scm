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
