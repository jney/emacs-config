(setq linum-disabled-modes-list '(eshell-mode wl-summary-mode compilation-mode))

(defun linum-on ()
  (unless (or (minibufferp) (member major-mode linum-disabled-modes-list))
    (linum-mode 1)))

(setq linum-format "%3d ")
