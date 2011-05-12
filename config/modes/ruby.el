(autoload 'inf-ruby "inf-ruby" "Run an inferior Ruby process" t)
(autoload 'inf-ruby-keys "inf-ruby" "" t)

(eval-after-load 'ruby-mode
  '(progn
     (add-hook 'ruby-mode-hook 'inf-ruby-keys)
     ; RET re-indents, then starts a new, indented line
     (define-key ruby-mode-map (kbd "RET") 'reindent-then-newline-and-indent)))

(global-set-key (kbd "C-h r") 'ri)

;; Rake files are ruby, too.
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.builder$" . ruby-mode))
(add-to-list 'auto-mode-alist '("config.ru" . ruby-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile$" . ruby-mode))

;; We never want to edit Rubinius bytecode
(add-to-list 'completion-ignored-extensions ".rbc")

;;; Rake

(defun pcomplete/rake ()
  "Completion rules for the `ssh' command."
  (pcomplete-here (pcmpl-rake-tasks)))

(defun pcmpl-rake-tasks ()
   "Return a list of all the rake tasks defined in the current
projects.  I know this is a hack to put all the logic in the
exec-to-string command, but it works and seems fast"
   (delq nil (mapcar '(lambda(line)
			(if (string-match "rake \\([^ ]+\\)" line) (match-string 1 line)))
		     (split-string (shell-command-to-string "rake -T") "[\n]"))))

(defun rake (task)
  (interactive (list (completing-read "Rake (default: default): "
                                      (pcmpl-rake-tasks))))
  (shell-command-to-string (concat "rake " (if (= 0 (length task)) "default" task))))


;; Clear the compilation buffer between test runs.
(eval-after-load 'ruby-compilation
  '(progn
     (defadvice ruby-do-run-w/compilation (before kill-buffer (name cmdlist))
       (let ((comp-buffer-name (format "*%s*" name)))
         (when (get-buffer comp-buffer-name)
           (with-current-buffer comp-buffer-name
             (delete-region (point-min) (point-max))))))
     (ad-activate 'ruby-do-run-w/compilation)))

;;; Flymake

;; flymake for ruby
(eval-after-load 'ruby-mode
  '(progn
     (require 'flymake)

     ;; Invoke ruby with '-c' to get syntax checking
     (defun flymake-ruby-init ()
       (let* ((temp-file (flymake-init-create-temp-buffer-copy
                          'flymake-create-temp-inplace))
              (local-file (file-relative-name
                           temp-file
                           (file-name-directory buffer-file-name))))
         (list "ruby" (list "-c" local-file))))

     (push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
     (push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)

     (push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3)
           flymake-err-line-patterns)

     (add-hook 'ruby-mode-hook
               (lambda ()
                 (when (and buffer-file-name
                            (file-writable-p
                             (file-name-directory buffer-file-name))
                            (file-writable-p buffer-file-name))
                   (local-set-key (kbd "C-c d")
                                  'flymake-display-err-menu-for-current-line)
                   (flymake-mode t))))))

;; flymake for erb
(defun flymake-erb-init ()
  (let* ((check-buffer (current-buffer))
         (temp-file (flymake-create-temp-inplace (buffer-file-name) "flymake"))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (save-excursion
      (save-restriction
        (widen)
        (with-temp-file temp-file
          (let ((temp-buffer (current-buffer)))
            (set-buffer check-buffer)
            (call-process-region (point-min) (point-max) "erb" nil temp-buffer nil "-x"))))
      (setq flymake-temp-source-file-name temp-file)
      (list "ruby" (list "-c" local-file)))))

(eval-after-load "flymake"
  '(progn
     (push '(".+\\.\\(rhtml\\|erb\\)$" flymake-erb-init) flymake-allowed-file-name-masks)
     (push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns)))

(defun turn-on-flymake-for-erb-files ()
  (when (string-match "\.erb$" (buffer-file-name))
    (flymake-mode 1)))
(add-hook 'find-file-hook 'turn-on-flymake-for-erb-files)

; ruby electric
(require 'ruby-electric)
(add-hook 'ruby-mode-hook 'ruby-electric-mode)
