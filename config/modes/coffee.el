(add-hook 'coffee-mode-hook
          '(lambda()
             (setq tab-width 2)
;;             (local-set-key (kbd "RET") 'newline)
             ))

(add-hook 'coffee-mode-hook 'esk-run-coding-hook)
(add-hook 'coffee-mode-hook 'esk-paredit-nonlisp)
