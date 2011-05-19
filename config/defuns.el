;;
(defun jney/backward-delete-rectangle-or-region-or-char ()
  "Backward delete a region or a single character."
  (interactive)
  (if cua--rectangle
      (cua-delete-rectangle)
    (if mark-active
        (kill-region (region-beginning) (region-end))
      (backward-delete-char 1))))

;;
(defun jney/backward-kill-line ()
  "Backward delete current line."
  (interactive)
  (kill-line 0))

;;
(require 'thingatpt)
(defun jney/change-num-at-point (fn)
  (let* ((num (string-to-number (thing-at-point 'word)))
         (bounds (bounds-of-thing-at-point 'word)))
    (save-excursion
      (goto-char (car bounds))
      (kill-word 1)
      (insert (number-to-string (funcall fn num 1))))))

;;
(defun jney/change-num-at-point/+ ()
  (interactive)
  (jney/change-num-at-point '+))

;;
(defun jney/change-num-at-point/- ()
  (interactive)
  (jney/change-num-at-point '-))

;;
(defun jney/close-tab ()
  (interactive)
  (when (functionp 'tabbar-mode)
    (tabbar-mode 0)
    (tabbar-mode 1))
  (kill-buffer-and-window))

;;
(defun jney/copy-current-line ()
  "Copy current line omitting indentation."
  (interactive)
  (let ((end (progn (end-of-line) (point)))
        (start (progn (beginning-of-line-text) (point))))
    (kill-ring-save start end)))

;;
(defun jney/create-line-above ()
  "Create a new line above."
  (interactive)
  (beginning-of-line)
  (newline-and-indent)
  (forward-line -1)
  (indent-according-to-mode))

;;
(defun jney/create-line-below ()
  "Create a new line below."
  (interactive)
  (end-of-line)
  (newline-and-indent))

;;
(defun jney/delete-line ()
  "Delete current line."
  (interactive)
  (insert "_")
  (beginning-of-line)
  (kill-line)
  (kill-line))

;;
(defun jney/duplicate-line ()
  "Duplicate current line"
  (interactive)
  (let ((start (progn (beginning-of-line) (point)))
	(end (progn (next-line 1) (beginning-of-line) (point))))
    (insert-buffer-substring (current-buffer) start end)
    (forward-line -1)))

;;
(defun jney/go-to-tab-or-buffer/next ()
  (interactive)
  (if tabbar-current-tabset
      (tabbar-forward-tab)
    (next-buffer)))
;;
(defun jney/go-to-tab-or-buffer/previous ()
  (interactive)
  (if tabbar-current-tabset
      (tabbar-backward-tab)
    (previous-buffer)))

;;
(defun jney/ido-find-project ()
  "Open a project from src folder"
  (interactive)
  (find-file
   (concat "~/src/" (ido-completing-read
                     "Project: " (directory-files "~/src/" nil "^[^.]")))))

;; from http://platypope.org/blog/2007/8/5/a-compendium-of-awesomeness
;; I-search with initial contents
(defvar jney/isearch-initial-string nil)

(defun jney/isearch-set-initial-string ()
  (remove-hook 'isearch-mode-hook 'jney/isearch-set-initial-string)
  (setq isearch-string jney/isearch-initial-string)
  (isearch-search-and-update))

(defun jney/isearch-forward-at-point (&optional regexp-p no-recursive-edit)
  "Interactive search forward for the symbol at point."
  (interactive "P\np")
  (if regexp-p (isearch-forward regexp-p no-recursive-edit)
    (let* ((end (progn (skip-syntax-forward "w_") (point)))
           (begin (progn (skip-syntax-backward "w_") (point))))
      (if (eq begin end)
          (isearch-forward regexp-p no-recursive-edit)
        (setq jney/isearch-initial-string (buffer-substring begin end))
        (add-hook 'isearch-mode-hook 'jney/isearch-set-initial-string)
        (isearch-forward regexp-p no-recursive-edit)))))

;;
(defun jney/goto-match-paren (arg)
  "Go to the matching  if on (){}[], similar to vi style of % "
  (interactive "p")
  ;; first, check for "outside of bracket" positions expected by forward-sexp, etc.
  (cond ((looking-at "[\[\(\{]") (forward-sexp))
        ((looking-back "[\]\)\}]" 1) (backward-sexp))
        ;; now, try to succeed from inside of a bracket
        ((looking-at "[\]\)\}]") (forward-char) (backward-sexp))
        ((looking-back "[\[\(\{]" 1) (backward-char) (forward-sexp))
        (t nil)))

;;
(defun jney/move-text (arg)
  (cond
   ((and mark-active transient-mark-mode)
    (if (> (point) (mark))
        (exchange-point-and-mark))
    (let ((column (current-column))
          (text (delete-and-extract-region (point) (mark))))
      (forward-line arg)
      (move-to-column column t)
      (set-mark (point))
      (insert text)
      (exchange-point-and-mark)
      (setq deactivate-mark nil)))
   (t
    (let ((column (current-column)))
      (beginning-of-line)
      (when (or (> arg 0) (not (bobp)))
        (forward-line)
        (when (or (< arg 0) (not (eobp)))
          (transpose-lines arg))
        (forward-line -1))
      (move-to-column column t)))))

;;
(defun jney/move-text/down (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines down."
  (interactive "*p")
  (jney/move-text arg))

;;
(defun jney/move-text/up (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines up."
  (interactive "*p")
  (jney/move-text (- arg)))

;;
(defun jney/reload-config ()
  "Reload config file."
  (load-file "~/.emacs.d/init"))

;;
(defun jney/replace ()
  "Replace in region or in page."
  (interactive)
  (cond (mark-active
         (narrow-to-region)
         (beginning-of-buffer)
         (replace-regexp)
         (widen))
        (t (beginning-of-buffer)
           (replace-regexp))))

;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun jney/rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
    (filename (buffer-file-name)))
    (if (not filename)
    (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
      (message "A buffer named '%s' already exists!" new-name)
    (progn
      (rename-file name new-name 1)
      (rename-buffer new-name)
      (set-visited-file-name new-name)
      (set-buffer-modified-p nil))))))

;;
(defun jney/shebang-to-mode ()
  (interactive)
  (let*
      ((bang (buffer-substring (point-min) (prog2 (end-of-line) (point) (move-beginning-of-line 1))))
       (mode (progn
               (string-match "^#!.+[ /]\\(\\w+\\)$" bang)
               (match-string 1 bang)))
       (mode-fn (intern (concat mode "-mode"))))
    (when (functionp mode-fn)
      (funcall mode-fn))))

;; Functions for configuring window geometry and placement
(defun jney/smart-split ()
  "Split the frame into 80-column sub-windows, and make sure no window has
   fewer than 80 columns."
  ; From http://hjiang.net/archives/253
  (interactive)
  (defun jney/smart-split-helper (w)
    "Helper function to split a given window into two, the first of which has
     80 columns."
    (if (> (window-width w) (* 2 81))
    (let ((w2 (split-window w 82 t)))
      (jney/smart-split-helper w2))))
  (jney/smart-split-helper nil))

;; function to open a new tab, suppressing new frame creation
(defun jney/tabbar-new-tab (&optional mode)
  "Creates a new tab, containing an empty buffer (with major-mode MODE
if specified), in current window."
  (interactive)
  (let ((one-buffer-one-frame nil))
    (new-empty-buffer nil mode)))

;;
(defun jney/toggle-fullscreen ()
  "Toggle to fullscreen."
  (interactive)
  (if (functionp 'ns-toggle-fullscreen)
      (ns-toggle-fullscreen)
    (toggle-fullscreen)))

;;
(defun jney/toggle-nav ()
  "Toggle nav."
  (interactive)
  (if (eq nil (get-buffer "*nav*"))
      (nav)))
