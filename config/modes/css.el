(add-hook 'css-mode-hook
          '(lambda ()
             (setq css-indent-level 2)
             (add-hook 'after-save-hook (lambda () (css-check)))
             ; (autopair-mode 1)
             (rainbow-mode 1)))

; (add-hook 'css-mode-hook 'esk-run-coding-hook)
; (add-hook 'css-mode-hook 'esk-paredit-nonlisp)


