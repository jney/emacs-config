(autoload 'nav "nav" "" t)
(add-hook 'nav-mode-hook
          '(lambda ()
             (dedicated-mode 1)
             (linum-mode 0)
             (tabbar-local-mode 0)))
