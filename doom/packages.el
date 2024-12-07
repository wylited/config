;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(package! typst-ts-mode :recipe (:host sourcehut :repo "meow_king/typst-ts-mode" :files ("*.el" "dist")))
(package! outline-ident-mode :recipe (:host sourcehut :repo "meow_king/outline-indent-mode" :files ("*.el" "dist")))
(package! tip :recipe (:host sourcehut :repo "mafty/tip" :files ("*.el" "dist")))

(package! org-roam)

(package! org-modern)
(package! svg-tag-mode)
(package! svg-lib)

(package! ement)

(package! copilot
  :recipe (:host github :repo "copilot-emacs/copilot.el" :files ("*.el")))

(package! wakatime-mode)
