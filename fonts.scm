(define-module (fonts)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system font))


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
   (home-page "https://www.nerdfonts.com/")
   (synopsis "Symbols-only nerd fonts dayo")
   (description
    "symbols-nerd-font description dayo")
   (license license:expat)))

(define-public font-ubuntu
  (package
   (name "font-ubuntu")
   (version "0.83")
   (source (origin
            (method url-fetch)
            (uri (string-append
                  "https://assets.ubuntu.com/v1/0cef8205-ubuntu-font-family-"
                  version
                  ".zip"))
            (sha256
             (base32
              "1kwfsvqkkh0928mf75md37g150hs46wqnhzgkzqm5mbga91b78k1"))))
   (build-system font-build-system)
   (home-page "https://design.ubuntu.com/font")
   (synopsis "Ubuntu font family")
   (description
    "The Ubuntu font family is a sans-serif typeface family available in 22
styles plus a variable font with adjustable weight and width axes.  Its
fixed-width companion, Ubuntu Mono, comes in 8 styles and a variable font with
an adjustable weight axis.")
   (license license:silofl1.1))) ; there is no ubuntu license in licenses.scm

