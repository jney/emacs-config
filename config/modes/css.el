(add-hook 'css-mode-hook
          '(lambda ()
             (set-fill-column 79)
             (setq css-indent-offset 2)
             (add-hook 'after-save-hook
                       (lambda () (css-check)) nil t)
             (autopair-mode 1)
             (rainbow-mode 1)))

(add-hook 'css-mode-hook 'run-coding-hook)
(add-hook 'css-mode-hook 'esk-paredit-nonlisp)

;; pip install cssutils
(defun flymake-css-init ()
      (let* ((temp-file (flymake-init-create-temp-buffer-copy
                         'flymake-create-temp-inplace))
             (local-file (file-relative-name
                          temp-file
                          (file-name-directory buffer-file-name))))
        (list "cssparse" (list local-file))))
    (add-to-list 'flymake-allowed-file-name-masks
                 '("\\.css$" flymake-css-init))
    (add-to-list 'flymake-err-line-patterns
                 '("\\(.*\\) \\[\\([0-9]+\\):\\([0-9]+\\): \\(.*\\)\\]"
                   nil 2 3 1))
    (add-hook 'css-mode-hook
              (lambda () (flymake-mode t)))
