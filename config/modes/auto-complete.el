;; everything about autocompletion
;; auto-complete and yasnippets
(require 'auto-complete)
(require 'auto-complete-yasnippet)
(require 'ac-dabbrev)

;; Don't ignore case and don't be smart
(setq ac-ignore-case nil)
(setq ac-use-fuzzy t)
(setq ac-use-quick-help t)
(define-key ac-completing-map [(return)] 'ac-complete)
(define-key ac-completing-map [(escape)] 'ac-stop)
(define-key ac-completing-map [(tab)] 'ac-next)
(define-key ac-completing-map [(shift tab)] 'ac-previous)
(add-to-list 'ac-modes 'brandnew-mode)

(setq ac-sources
     (list ac-source-dabbrev))

;; Yasnippet workaround for ruby-electric-mode
;; See: http://code.google.com/p/yasnippet/issues/detail?id=71
(defun yas/advise-indent-function (function-symbol)
  (eval `(defadvice ,function-symbol (around yas/try-expand-first activate)
           ,(format
             "Try to expand a snippet before point, then call `%s' as usual"
             function-symbol)
           (let ((yas/fallback-behavior nil))
             (unless (and (interactive-p)
                          (yas/expand))
               ad-do-it)))))
(yas/advise-indent-function 'ruby-indent-line)

;; load my own snippets
(yas/load-directory (concat dotfiles-dir "config/snippets/"))

;; auto-complete for everything
(global-auto-complete-mode t)
(ac-config-default)
