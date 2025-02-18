;;; Copyright © 2023 pat-hwaki
;;; Copyright © 2023 Zheng Junjie <873216071@qq.com>
(define-module (cn-foliate)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages python)
  #:use-module (gnu packages webkit)
  #:use-module (guix build utils)
  #:use-module (guix build-system meson)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module ((guix licenses) #:prefix license:))

(define-public cn-foliate
  (let* ((commit "34b9079a1b7a325febfb3728f632e636d402a372")
         (revision "0")
         (version* (git-version "3.2.1" revision commit))
         (foliate-js
          (origin
            (method git-fetch)
            (uri (git-reference
                  (url "https://github.com/johnfactotum/foliate-js")
                  (commit "34b9079a1b7a325febfb3728f632e636d402a372")))
            (file-name
             (git-file-name "foliate-js" version*))
            (sha256
             (base32
              "01l4adg41cm934ssif0amajq4ka9xi1clkjryisixkhzsmxzcljv")))))
    (package
      (name "cn-foliate")
      (version version*)
      (source (origin
                (method git-fetch)
                (uri (git-reference
                      (url "https://github.com/johnfactotum/foliate.git")
                      (commit "afc4b033e76904f1d20604640b2727a58a2e8106")))
                (file-name (git-file-name name version))
                (sha256
                 (base32
                  "1g2jxa3jm0mfj4jx45gw5vq5rimdsyjym3lgw2dvhns7nb42ik8j"))))
      (build-system meson-build-system)
      (arguments
       (list #:glib-or-gtk? #t
             #:phases
             #~(modify-phases %standard-phases
                 (add-after 'unpack 'copy-foliate-js
                   (lambda _
                     (copy-recursively #$foliate-js "src/foliate-js")))
                 (add-after 'unpack 'skip-gtk-update-icon-cache
                   (lambda _
                     (substitute* "meson.build"
                       (("gtk_update_icon_cache: true")
                        "gtk_update_icon_cache: false"))))
                 (add-after 'glib-or-gtk-wrap 'wrap-program
                   (lambda* (#:key outputs #:allow-other-keys)
                     (let ((prog (string-append (assoc-ref outputs "out")
                                                "/bin/foliate")))
                       ;; Put existing typelibs before sushi's deps, so as to
                       ;; correctly infer gdk-pixbuf.
                       (wrap-program prog
                         `("GI_TYPELIB_PATH" suffix
                           (,(getenv "GI_TYPELIB_PATH")))
                         ;; for icon.
                         `("GDK_PIXBUF_MODULE_FILE" =
                           (,(getenv "GDK_PIXBUF_MODULE_FILE"))))))))))

      (native-inputs
       (list pkg-config
             `(,glib "bin")
             gettext-minimal
             gobject-introspection
             desktop-file-utils
             foliate-js))
      (inputs
       (list libadwaita
             glib
             glib-networking
             webkitgtk
             gtk
             gjs))
      (home-page "https://johnfactotum.github.io/foliate/")
      (synopsis "Read books in style")
      (description "A simple and modern GTK e-book reader")
      ;;             foliate       foliate-js
      (license (list license:gpl3 license:expat)))))
