;; shortcut for shell
(global-set-key "\C-x\C-z" 'shell)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(eval-after-load 'shell
  '(progn
     (define-key shell-mode-map [up] 'comint-previous-input)
     (define-key shell-mode-map [down] 'comint-next-input)
     (define-key shell-mode-map "\C-p" 'comint-previous-input)
     (define-key shell-mode-map "\C-n" 'comint-next-input)))

;; disabling smart-tab for ansi-term
(defadvice ansi-term (after ansi-term-after-advice (org))
  "disable smart tab mode after an ansi-term loads"
  (smart-tab-mode 0))
(ad-activate 'ansi-term)
