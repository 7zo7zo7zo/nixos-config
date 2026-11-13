;;; my-org.el --- Org-mode configuration -*- lexical-binding: t; -*-
(provide 'my-org)

(defun my/org-mode-setup ()
(org-indent-mode) ; indents text and hides leading asterisks
(variable-pitch-mode 1)
(visual-line-mode 1)) ; makes text wrap

(defun my/org-font-setup ()
  ;; Replace list hyphens with bullets.
  (font-lock-add-keywords
   'org-mode
   '(("^ *\\([-]\\) "
      (0 (prog1 ()
           (compose-region (match-beginning 1)
                           (match-end 1)
                           "•"))))))

  ;; Set heading sizes.
  (dolist (face '((org-level-1 . 1.9)
                  (org-level-2 . 1.8)
                  (org-level-3 . 1.7)
                  (org-level-4 . 1.6)
                  (org-level-5 . 1.5)
                  (org-level-6 . 1.4)
                  (org-level-7 . 1.3)
                  (org-level-8 . 1.2)))
    (set-face-attribute (car face) nil
			                  :weight 'regular
			                  :height (cdr face)))

  ;; Keep code-related Org elements fixed-pitch.
  (set-face-attribute 'org-block nil
                      :foreground nil
                      :inherit 'fixed-pitch)
  (set-face-attribute 'org-table nil
                      :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-formula nil
                      :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil
                      :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil
                      :inherit '(shadow fixed-pitch)
                      :height 'unspecified)
  (set-face-attribute 'org-special-keyword nil
                      :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil
                      :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil
                      :inherit 'fixed-pitch)
  (set-face-attribute 'line-number nil
                      :inherit 'fixed-pitch)
  (set-face-attribute 'line-number-current-line nil
                      :inherit 'fixed-pitch))

(use-package org
  :commands (org-capture org-agenda)

  :bind
  (("C-c c" . org-capture)
   ("C-c a" . org-agenda))

  :hook
  (org-mode . my/org-mode-setup)

  :config
  (setq org-directory "~/Documents/Org"
	org-agenda-files
	(list org-directory
              "~/Documents/Org/Roam")

	org-agenda-prefix-format
	'((agenda . " %i %?-12t% s")
          (todo   . " %i ")
          (tags   . " %i ")
          (search . " %i "))

	org-ellipsis " ▼"
	org-agenda-start-with-log-mode t
	org-log-done 'time
	org-log-into-drawer t
	org-hide-emphasis-markers t

	org-capture-templates
	'(("i" "Inbox" entry
           (file "refile.org")
           "* %?")

          ("t" "Task" entry
           (file "todo.org")
           "* TODO %?")

          ("e" "Event" entry
           (file "events.org")
           "* %^{Event}\n  %^t\n  %?")

          ("E" "Multi-day event" entry
           (file "events.org")
           "* %^{Event}\n%^{Start}t--%^{End}t\n%?")))

  (my/org-font-setup))

(use-package org-roam
:custom
(org-roam-directory (file-truename "~/Documents/Org/Roam"))
:bind (("C-c n l" . org-roam-buffer-toggle)
       ("C-c n f" . org-roam-node-find)
       ("C-c n g" . org-roam-graph)
       ("C-c n i" . org-roam-node-insert)
       ("C-c n c" . org-roam-capture)
       ;; Dailies
       ("C-c n j" . org-roam-dailies-capture-today))
:config
;; If you're using a vertical completion framework, you might want a more informative completion interface
(setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
(org-roam-db-autosync-mode)
;; If using org-roam-protocol
(require 'org-roam-protocol))

(use-package olivetti
  :custom
  (olivetti-body-width 0.7)
  (olivetti-minimum-body-width 80)
  (olivetti-recall-visual-line-mode-entry-state t)
  :hook
  (org-mode . olivetti-mode))

(defvar my/firefox-block-timer nil
  "Timer used to check whether Firefox should be blocked.")

(defun my/firefox-block-if-idle ()
  "Close Firefox unless an Org clock is running."
  (interactive)
  (unless (and (fboundp 'org-clocking-p)
               (org-clocking-p))
    (let ((process
           (start-process "firefox-block" nil
                          "pkill" "-x" "\\.firefox-wrappe")))
      (set-process-sentinel process #'ignore))))

(defun my/firefox-check-after-clock ()
  "Check Firefox shortly after an Org clock stops."
  (run-at-time 0.5 nil #'my/firefox-block-if-idle))

(add-hook 'org-clock-out-hook
          #'my/firefox-check-after-clock)

(add-hook 'org-clock-cancel-hook
          #'my/firefox-check-after-clock)

;; Cancel the previous timer when reloading.
(when (timerp my/firefox-block-timer)
  (cancel-timer my/firefox-block-timer))

;; Check after 2 seconds, then every 60 seconds.
(setq my/firefox-block-timer
      (run-with-timer 2 60 #'my/firefox-block-if-idle))
