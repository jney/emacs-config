(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(autoload 'espresso-mode "espresso")
(setq espresso-indent-level 2)

(add-hook 'js2-mode-hook
          '(lambda ()
             (setq js-indent-offset 2)))
