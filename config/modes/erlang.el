(let* ( (emacs-version "2.6.6.3")
        (tools-path
         (concat "/usr/local/lib/erlang/lib/tools-" emacs-version "/emacs")))
  (when (file-exists-p tools-path)
    (setq load-path (cons tools-path load-path)
          erlang-root-dir "/usr/local/lib/erlang"
          exec-path (cons "/usr/local/lib/erlang/bin" exec-path))
    (require 'erlang-start)
    (defvar inferior-erlang-prompt-timeout t)))
