(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(add-hook 'org-mode-hook
          '(lambda ()
             (define-key org-mode-map "\C-cl" 'org-store-link)
             (define-key org-mode-map "\C-cc" 'org-capture)
             (define-key org-mode-map "\C-ca" 'org-agenda)
             (define-key org-mode-map "\C-cb" 'org-iswitchb)))

(setq org-log-done t)

(setq org-agenda-files (list "~/Documents/org/figaro.org"
                             "~/Documents/org/personal.org"))
