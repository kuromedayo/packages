(define-module (fonts)
  #:use-module (ice-9 regex)
  #:use-module (guix utils)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix build-system font)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system meson)
  #:use-module (guix build-system trivial)
  #:use-module (gnu packages)
  #:use-module (gnu packages c)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages gd)
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages sdl)
  #:use-module (gnu packages xorg))

(define-public font-openmoji
  (package
    (name "font-openmoji")
    (version "15.1.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/hfg-gmuend/openmoji/")
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1iil5jmkkqrqgq06q3gvgv7j1bq8499q3h2340prwlfi2sqcqzlk"))))
    (build-system font-build-system)
    (arguments
     (list
      #:modules `((ice-9 ftw)
                  (guix build font-build-system)
                  (guix build utils))
      #:phases
      #~(modify-phases %standard-phases
          (add-after 'unpack 'chdir
            (lambda _
              (chdir "font")))
          (add-after 'chdir 'strip-alternative-variants
            (lambda _
              (let ((keep '("OpenMoji-black-glyf" "OpenMoji-color-glyf_colr_0"
                            "." "..")))
                (for-each (lambda (f)
                            (unless (member f keep)
                              (delete-file-recursively f)))
                          (scandir ".")))))
          (add-before 'install-license-files 'chdir-back
            (lambda _
              (chdir ".."))))))
    (home-page "https://openmoji.org")
    (synopsis "Font for rendering emoji characters")
    (description
     "This package provides the OpenMoji font in both color and black
variants.")
    (license license:cc-by-sa4.0)))

(define-public symbols-nerd-font
  (package
    (name "symbols-nerd-font")
    (version "3.3.0")
    (source (origin
              (method url-fetch)
              (uri (string-append
                    "https://github.com/ryanoasis/nerd-fonts/releases/download/v"
                    version
                    "/NerdFontsSymbolsOnly.zip"))
              (sha256
               (base32
                "0h53ldrkydxaps4kv087k71xgmb40b1s2nv2kvxc4bvs3qy60y10"))))
    (build-system font-build-system)
    (home-page "https://www.nerdfonts.com")
    (synopsis "Patched developer fonts with extra glyphs")
    (description "This package provides patched developer-targeted fonts with a
high number of additional glyphs.  It includes extra glyphs from popular iconic
fonts such as Font Awesome, Devicons, Octicons, and more.")
    (license (list license:expat license:silofl1.1))))

;; (define-public font-ubuntu
;;   (package
;;    (name "font-ubuntu")
;;    (version "0.83")
;;    (source (origin
;;             (method url-fetch)
;;             (uri (string-append
;;                   "https://assets.ubuntu.com/v1/0cef8205-ubuntu-font-family-"
;;                   version
;;                   ".zip"))
;;             (sha256
;;              (base32
;;               "1kwfsvqkkh0928mf75md37g150hs46wqnhzgkzqm5mbga91b78k1"))))
;;    (build-system font-build-system)
;;    (home-page "https://design.ubuntu.com/font")
;;    (synopsis "Ubuntu font family")
;;    (description
;;     "The Ubuntu font family is a sans-serif typeface family available in 22
;; styles plus a variable font with adjustable weight and width axes.  Its
;; fixed-width companion, Ubuntu Mono, comes in 8 styles and a variable font with
;; an adjustable weight axis.")
;;    (license license:silofl1.1))) ; there is no ubuntu license in licenses.scm

