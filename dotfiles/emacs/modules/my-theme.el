;;; my-theme.el --- Theming settings -*- lexical-binding: t; -*-
(provide 'my-theme)

(defvar my/default-font-size 160)

(set-face-attribute 'default nil
                    :family "Aporetic Serif Mono"
                    :height my/default-font-size
                    :weight 'normal)

(set-face-attribute 'fixed-pitch nil
                    :family "Aporetic Serif Mono")

(set-face-attribute 'variable-pitch nil
                    :family "Aporetic Sans")

(use-package au-themes
  :config
  (load-theme 'au-herbarium-night t))

(use-package doom-modeline
  :init (doom-modeline-mode 1))
