;;; early-init.el --- Early initialization -*- lexical-binding: t; -*-
(setq ring-bell-function 'ignore)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(startup-redirect-eln-cache
 (expand-file-name "~/.local/state/emacs/var/eln-cache/"))
