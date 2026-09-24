;;; init.el --- Emacs configuration -*- lexical-binding: t; -*-

;; You will most likely need to adjust this font size for your system!
(defvar my/default-font-size 160)
(defvar my/default-variable-font-size 160)

(setq make-backup-files nil)
(setq auto-save-default nil)

(setq inhibit-startup-message t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room
(menu-bar-mode -1)          ; Disable the menu bar

;; (setq visible-bell t)       ; Set up the visible bell
(setq ring-bell-function 'ignore)

(column-number-mode)
(global-display-line-numbers-mode t)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                 term-mode-hook
                 shell-mode-hook
                 treemacs-mode-hook
                 eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(set-face-attribute 'default nil :font "JetBrains Mono Nerd Font" :height my/default-font-size)

;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil :font "JetBrains Mono Nerd Font" :height my/default-font-size)

;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil :font "Cantarell" :height my/default-variable-font-size :weight 'regular)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(which-key-mode 1)

(require 'use-package)
;; Packages are installed through Nix, so use-package should only
;; configure them and should not try to download them.
(setq use-package-always-ensure nil)

(use-package no-littering
  :init
  (setq no-littering-etc-directory
        (expand-file-name "~/.local/state/emacs/etc/"))
  (setq no-littering-var-directory
        (expand-file-name "~/.local/state/emacs/var/")))

(setq custom-file (no-littering-expand-etc-file-name "custom.el"))

(load (expand-file-name "lisp/completion.el"
  user-emacs-directory))

(load (expand-file-name "lisp/doom.el"
  user-emacs-directory))

(load (expand-file-name "lisp/evil.el"
  user-emacs-directory))

(load (expand-file-name "lisp/org.el"
  user-emacs-directory))

(load (expand-file-name "lisp/project.el"
  user-emacs-directory))
