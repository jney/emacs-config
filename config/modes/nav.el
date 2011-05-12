(autoload 'nav "nav" "" t)
(add-hook 'nav-mode-hook
          '(lambda ()
             (linum-mode 0)
             (dedicated-mode 1)
             (tabbar-local-mode 0)))
