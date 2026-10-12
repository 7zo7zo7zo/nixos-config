(setq doom-font
      (font-spec :family "JetBrainsMono Nerd Font" :size 20)
      doom-variable-pitch-font
      (font-spec :family "Cantarell" :size 20))

; (setq doom-theme 'doom-palenight)
; (setq doom-theme 'doom-badger)
; (setq doom-theme 'doom-vibrant)
(setq doom-theme 'doom-one)

;; Don't persist undo history between Emacs sessions.
(remove-hook 'undo-fu-mode-hook #'global-undo-fu-session-mode)

;; ---------------------------------------------------------------------------
;; Org
;; ---------------------------------------------------------------------------

(after! org
  (setq org-directory "~/Documents/Org"
        org-agenda-files
        (list org-directory
              "~/Documents/Org/Roam")

        org-agenda-prefix-format
        '((agenda . " %i %?-12t% s")
          (todo   . " %i ")
          (tags   . " %i ")
          (search . " %i "))

        ; org-agenda-tags-column 0
        ; org-agenda-block-separator ?─
        ; org-agenda-time-grid
        ; '((daily today require-timed)
        ;   (800 1000 1200 1400 1600 1800 2000)
        ;   " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
        ; org-agenda-current-time-string
        ; "⭠ now ─────────────────────────────────────────────────"

        org-ellipsis " ▾"
        org-agenda-start-with-log-mode t
        org-log-done 'time
        org-log-into-drawer t
        org-hide-emphasis-markers t
        org-pretty-entities t

        org-capture-templates
        '(("i" "Inbox" entry
           (file "refile.org")
           "* %?")

          ("t" "Task" entry
           (file "todo.org")
           "* TODO %?")

          ("e" "Event" entry
           (file "events.org")
           "* %^{Event}\n  %^T\n  %?")

          ("E" "Multi-day event" entry
           (file "events.org")
           "* %^{Event}\n%^{Start}t--%^{End}t\n%?")))

  ;; Replace list hyphens with bullets
  (font-lock-add-keywords
    'org-mode
    '(("^ *\\([-]\\) "
       (0 (prog1 ()
            (compose-region
              (match-beginning 1)
              (match-end 1)
              "•"))))))


  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute
      (car face) nil
      :font "Cantarell"
      :weight 'regular
      :height (cdr face)))

  ;; Keep code-like Org elements fixed-pitch
  (set-face-attribute 'org-block nil
                      :foreground 'unspecified
                      :inherit 'fixed-pitch)
  (set-face-attribute 'org-table nil
                      :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-formula nil
                      :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil
                      :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil
                      :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil
                      :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil
                      :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil
                      :inherit 'fixed-pitch)

  ;; Keep line numbers monospace
  (set-face-attribute 'line-number nil
                      :inherit 'fixed-pitch)
  (set-face-attribute 'line-number-current-line nil
                      :inherit 'fixed-pitch))


;; ---------------------------------------------------------------------------
;; Org buffer setup
;; ---------------------------------------------------------------------------

(add-hook! 'org-mode-hook
  #'org-indent-mode
  #'visual-line-mode
  #'variable-pitch-mode)


;; ---------------------------------------------------------------------------
;; Org Modern
;; ---------------------------------------------------------------------------

; (after! org-modern
;   (setq org-modern-star 'replace
;         org-modern-replace-stars "●◉○◌◦⠂⠐"
;
;         ;;org-modern-agenda t
;
;         org-modern-progress nil
;
;         ;; Leave TODO/DONE keywords alone
;         org-modern-todo nil
;
;         ;; Leave timestamps/deadlines alone
;         org-modern-timestamp nil
;
;         ;; Leave tags alone
;         org-modern-tag nil
;
;         org-modern-list
;         '((?+ . "◦")
;           (?- . "–")
;           (?* . "•"))
;
;         org-modern-checkbox
;         '((?X . "󰄵")
;           (?- . "󰡖")
;           (?\s . "󰄱"))))


;; ---------------------------------------------------------------------------
;; Visual fill
;; ---------------------------------------------------------------------------

(defun my/org-mode-visual-fill ()
  (setq-local visual-fill-column-width 100
              visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package! visual-fill-column
  :hook (org-mode . my/org-mode-visual-fill))


(add-hook! 'org-mode-hook
  #'visual-line-mode
  (setq-local display-line-numbers nil))


;; ---------------------------------------------------------------------------
;; Org-roam
;; ---------------------------------------------------------------------------

(after! org-roam
  (setq org-roam-directory "~/Documents/Org/Roam")
  (org-roam-setup))

; (use-package! org-bullets
;   :after org
;   :hook (org-mode . org-bullets-mode)
;   :config
;   (setq org-bullets-bullet-list
;         '("●" "◉" "○" "◌" "◦" "⠂" "⠐")))
