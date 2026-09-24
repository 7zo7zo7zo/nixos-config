;;; org.el --- Org mode configuration -*- lexical-binding: t; -*-

(defun my/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (visual-line-mode 1))

(defun my/org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :font "Cantarell" :weight 'regular :height (cdr face)))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil    :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-table nil    :inherit 'fixed-pitch)
  (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil     :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil    :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil  :inherit 'fixed-pitch)
  (set-face-attribute 'line-number nil :inherit 'fixed-pitch)
  (set-face-attribute 'line-number-current-line nil :inherit 'fixed-pitch))

(use-package org
  :commands (org-capture org-agenda)

  :bind
  (("C-c c" . org-capture)
   ("C-c a" . org-agenda))

  :hook
  (org-mode . my/org-mode-setup)

  :config
  (setq org-directory "~/Documents/Org"

        ;; Scan every .org file directly inside org-directory.
        org-agenda-files (list org-directory)

        org-agenda-prefix-format
        '((agenda . " %i %?-12t% s")
          (todo   . " %i ")
          (tags   . " %i ")
          (search . " %i "))

        org-ellipsis " ▾"
        org-agenda-start-with-log-mode t
        org-log-done 'time
        org-log-into-drawer t

        org-capture-templates
        '(("i" "Inbox" entry
           (file "inbox.org")
           "* %?\n  Captured: %U")

           ("t" "Task" entry
           (file "inbox.org")
           "* TODO %?\n  Captured: %U")

          ("e" "Event" entry
           (file "events.org")
           "* %^{Event}\n  %^T\n  %?")

          ("E" "Multi-day event" entry
           (file "events.org")
         "* %^{Event}\n%^{Start}t--%^{End}t\n%?")))

  (my/org-font-setup))

(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))


(defun efs/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . efs/org-mode-visual-fill))

(use-package org-roam
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/Documents/Org")
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert))
  :config
  (org-roam-setup))
