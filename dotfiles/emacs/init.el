;;; init.el --- Main configuration -*- lexical-binding: t; -*-

(require 'use-package)
;; Packages are installed through Nix, so use-package should only
;; configure them and should not try to download them.
(setq use-package-always-ensure nil)

(setq inhibit-startup-screen t
      split-width-threshold nil)

;; Set tab width to 2 spaces
(setq-default
 indent-tabs-mode nil
 tab-width 2
 standard-indent 2)

;; Make undo/redo behave the way you expect
(keymap-global-set "C-/" #'undo-only)

(use-package no-littering
  :init
  (setq no-littering-etc-directory
        (expand-file-name "~/.local/state/emacs/etc/"))
  (setq no-littering-var-directory
        (expand-file-name "~/.local/state/emacs/var/")))

(use-package server
  :config
  (unless (server-running-p)
    (server-start)))

(add-to-list 'load-path
             (expand-file-name "modules" user-emacs-directory))

(require 'my-theme)
(require 'my-org)
(require 'my-completion)
(require 'my-project)
