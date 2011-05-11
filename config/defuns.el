;;
(defun jney-backward-delete-rectangle-or-region-or-char ()
  "Backward delete a region or a single character."
  (interactive)
  (if cua--rectangle
      (cua-delete-rectangle)
    (if mark-active
        (kill-region (region-beginning) (region-end))
      (backward-delete-char 1))))

;;
(defun jney-backward-kill-line ()
  "Backward delete current line."
  (interactive)
  (kill-line 0))

;;
(defun jney-copy-current-line ()
  "Copy current line omitting indentation."
  (interactive)
  (let ((end (progn (end-of-line) (point)))
        (start (progn (beginning-of-line-text) (point))))
    (kill-ring-save start end)))

;;
(defun jney-create-line-above ()
  "Create a new line above."
  (interactive)
  (beginning-of-line)
  (newline-and-indent)
  (forward-line -1)
  (indent-according-to-mode))

;;
(defun jney-create-line-below ()
  "Create a new line below."
  (interactive)
  (end-of-line)
  (newline-and-indent))

;;
(defun jney-delete-line ()
  "Delete current line."
  (interactive)
  (insert "_")
  (beginning-of-line)
  (kill-line)
  (kill-line))

;;
(defun jney-duplicate-line ()
  "Duplicate current line"
  (interactive)
  (let ((start (progn (beginning-of-line) (point)))
	(end (progn (next-line 1) (beginning-of-line) (point))))
    (insert-buffer-substring (current-buffer) start end)
    (forward-line -1)))

;;
(defun jney-indent ()
  "Add indentation at the beginning of the line."
  (interactive)
  (beginning-of-line)
  (insert "  "))

;;
(defun jney-move-one-line-downward ()
  "Move current line downward once."
  (interactive)
  (forward-line)
  (transpose-lines 1)
  (forward-line -1))

;;
(defun jney-move-one-line-upward ()
  "Move current line upward once."
  (interactive)
  (transpose-lines 1)
  (forward-line -2))

;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun jney-rename-file-and-buffer (new-name)
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
(defun jney-shebang-to-mode ()
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
(defun jney-smart-split ()
  "Split the frame into 80-column sub-windows, and make sure no window has
   fewer than 80 columns."
  ; From http://hjiang.net/archives/253
  (interactive)
  (defun jney-smart-split-helper (w)
    "Helper function to split a given window into two, the first of which has
     80 columns."
    (if (> (window-width w) (* 2 81))
    (let ((w2 (split-window w 82 t)))
      (jney-smart-split-helper w2))))
  (jney-smart-split-helper nil))

;; function to open a new tab, suppressing new frame creation
(defun jney-tabbar-new-tab (&optional mode)
  "Creates a new tab, containing an empty buffer (with major-mode MODE
if specified), in current window."
  (interactive)
  (let ((one-buffer-one-frame nil))
    (new-empty-buffer nil mode)))

;;
(defun jney-toggle-fullscreen ()
  "Toggle to fullscreen."
  (interactive)
  (if (functionp 'ns-toggle-fullscreen)
      (ns-toggle-fullscreen)
    (toggle-fullscreen)))

