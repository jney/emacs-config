(add-hook 'whitespace-mode-hook
          '(lambda()
             (setq whitespace-space 'underline)
             (setq whitespace-style '(empty lines-tail tabs tab-mark trailing))
             ))

(autoload 'whitespace-mode           "whitespace" "Toggle whitespace visualization."        t)
(autoload 'whitespace-toggle-options "whitespace" "Toggle local `whitespace-mode' options." t)

