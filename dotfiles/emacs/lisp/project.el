;;; project.el --- Project configuration -*- lexical-binding: t; -*-

(use-package compile
  :hook
  (compilation-filter . ansi-color-compilation-filter))

(use-package project
  :custom
  (project-list-file
    (no-littering-expand-var-file-name "projects"))
  (project-mode-line t)
  (project-kill-buffers-display-list t))

(use-package envrc
  :hook (after-init . envrc-global-mode)
  :custom
  (envrc-async t))

(defun my/project-setup-after-envrc (buffer &rest _)
  "Set project commands after envrc updates BUFFER."
  (when (buffer-live-p buffer)
    (with-current-buffer buffer
      (when (and (project-current)
                 (executable-find "odin"))
        (setq-local compile-command "odin run src")))))

(with-eval-after-load 'envrc
  (advice-add 'envrc--apply
              :after
              #'my/project-setup-after-envrc))

(add-to-list 'major-mode-remap-alist
  '(c-mode . c-ts-mode))

(add-to-list 'major-mode-remap-alist
  '(c++-mode . c++-ts-mode))

(use-package odin-ts-mode
  :mode "\\.odin\\'")

(use-package nix-ts-mode
  :mode "\\.nix\\'")

;; If LSP is your jam, Eglot is your fix. Use the `eglot' command in a
;; programming major mode to boot up a language server and connect it
;; to Emacs.  Eglot does not install language servers for you, so you
;; must have the language server installed for a particular language
;; (e.g. rust-analyzer for Rust) before `eglot' will work its magic.
(use-package eglot
  ;; Uncomment these dotted pairs to automatically activate Eglot when
  ;; that major mode is active.
  ;;
  :hook ((odin-ts-mode . eglot-ensure)
          (nix-ts-mode . eglot-ensure)
          (c-ts-mode . eglot-ensure)
          (c++-ts-mode . eglot-ensure))
  :bind (("C-c ." . eglot-code-action-quickfix)))

;; Add breadcrumbs to the top of buffers.  Works great with Eglot.
(use-package breadcrumb
  :config
  (breadcrumb-mode))
