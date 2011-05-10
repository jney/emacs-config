;; load config for systemx
(setq system-type-specific-config
      (concat dotfiles-dir "config/system/" (symbol-name system-type) ".el"))

(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell
      (replace-regexp-in-string "[[:space:]\n]*$" ""
        (shell-command-to-string "$SHELL -l -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))
(when (equal system-type 'darwin) (set-exec-path-from-shell-PATH))

(load "config/defuns")
(load "config/packages")
(load "config/bindings")
(load "config/globals")
;; load some modes
(load "config/modes/auto-complete")
(load "config/modes/coffee")
(load "config/modes/css")
(load "config/modes/eshell")
(load "config/modes/jade")
(load "config/modes/js")
(load "config/modes/org")
(load "config/modes/shell")
(load "config/modes/whitespace")

(if (file-exists-p system-type-specific-config)
    (load system-type-specific-config))

;; cua mode
(when (functionp 'cua-mode)
  (cua-mode 1))

;; switch to fullscreen
(jney-toggle-fullscreen)

(server-start)
