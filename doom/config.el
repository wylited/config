;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; PERSONAL SETUP

(setq user-full-name "wylited"
      user-mail-address "wylited@gmail.com"
      shell-file-name (executable-find "fish"))

;; VISUAL SETUP
;;

(setq-default
 window-combination-resize t
 x-stretch-cursor t)

(setq doom-theme 'doom-ayu-dark
      doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 20 :weight 'medium)
      doom-variable-pitch-font (font-spec :family "Lexend" :size 36 :weight 'light)
      truncate-string-ellipsis "…"
      display-line-numbers-type nil)

;; modeline       

(setq-default doom-modeline-enable-word-count nil
              doom-modeline-icon t
              doom-modeline-header-line nil
              doom-modeline-workspace-name t
              doom-modeline-time t
              doom-modeline-env-version t
              display-time-mode t)

;; EDITOR BEHAVIOUR SETUP
;;

(setq undo-limit 100000000
      evil-want-fine-undo t ; granular undo
      auto-save-default t)

(setq-default delete-by-moving-to-trash t)

;; ORG SETUP
;;

(setq org-directory "~/org/"
      org-support-shift-select t)

;; ORG BEAUTY setup
;;

(add-hook 'org-mode-hook 'variable-pitch-mode)
(with-eval-after-load 'org (global-org-modern-mode))

;; SVG TAG MODE
(setq svg-tag-tags
      '(("\\(:#[A-Za-z0-9]+\\)" . ((lambda (tag)
                                     (svg-tag-make tag :beg 2))))
        ("\\(:#[A-Za-z0-9]+:\\)$" . ((lambda (tag)
                                       (svg-tag-make tag :beg 2 :end -1))))));;

;; ORG AGENDA SETUP
;;

(setq org-todo-keywords '((sequence "TODO" "NEXT" "WAIT" "DONE" "|" "DONE" "PUSH" "HOLD" "CNCL")))


;; ORG ROAM SETUP
;;

(setq org-roam-directory (file-truename "/home/wyli/org/notes")
      org-roam-dailies-directory (file-truename "/home/wyli/org/notes/essayed")
      org-roam-dailies-capture-templates
      '(("d" "default" entry
         "* %?"
         :target (file+head "%<%Y-%m-%d>.org"
                            "#+title: %<%Y-%m-%d>\n"))))

(org-roam-db-autosync-mode)

;; ORG ATTACH IMAGE
;;

(defun custom-org-yank-image-file-name (uri)
  "Generate a custom file name for yanked images."
  (let* ((file-name (file-name-base (buffer-file-name)))
         (counter 1)
         (extension (file-name-extension uri t))
         (image-file (format "%s-img%d%s" file-name counter extension)))
    ;; Increment the counter until a unique file name is found
    (while (file-exists-p image-file)
      (setq counter (1+ counter))
      (setq image-file (format "%s-img%d%s" file-name counter extension)))
    image-file))

(setq org-yank-image-file-name-function #'custom-org-yank-image-file-name)

;; TYPST SETUP
;;

(setq typst-ts-mode-watch-options "--open")

(with-eval-after-load 'eglot
  (with-eval-after-load 'typst-ts-mode
    (add-to-list 'eglot-server-programs
                 `((typst-ts-mode) .
                   ,(eglot-alternatives `(,typst-ts-lsp-download-path
                                          "tinymist"
                                          "typst-lsp"))))))
(setq-default eglot-workspace-configuration
              '(:exportPdf "onSave"))


;; COPILOT
;;

(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))

;; WAKATIME
;;

(use-package! wakatime-mode
  :ensure t)

(setq wakatime-api-key "42feae2a-7882-41ee-a8b5-6015e0fb3891"
      wakatime-cli-path "/usr/bin/wakatime")

(global-wakatime-mode)
