;; load or install el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (url-retrieve
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
   (lambda (s)
     (end-of-buffer)
     (eval-print-last-sexp))))

;; Contains the list of packages we are using
(setq el-get-sources
      '(
        ;; misc
        (:name anything
               :after (lambda () (load "config/modes/anything")))
        (:name auto-complete)
        (:name auto-complete-yasnippet
               :type http
               :url "http://www.cx4a.org/pub/auto-complete-yasnippet.el")
        (:name autopair)
        (:name erc)
        (:name magit)
        (:name markdown-mode)
        (:name naquadah-theme
               :after (lambda () (require 'naquadah-theme)))
        (:name rainbow-mode)
        (:name tabbar
               :type elpa)
        (:name tabbar-ruler
               :type elpa
               :after (lambda () (load "config/modes/tabbar")))
        (:name textmate
               :type git
               :url "git://github.com/defunkt/textmate.el"
               :load "textmate.el"
               :after (lambda () (textmate-mode 1)))
        (:name yaml-mode)
        (:name yasnippet)

        ;; ruby packages
        (:name rvm)
        (:name inf-ruby
               :type elpa
               :load "inf-ruby.el"
               :after (lambda () (load "config/modes/inf-ruby")))
        (:name rhtml
               :type git
               :url "https://github.com/eschulte/rhtml.git"
               :compile ()
               :features rhtml-mode)
        (:name rinari)
        (:name ruby-compilation :type elpa)
        (:name ruby-electric
               :type elpa)
        (:name ruby-mode
               :type elpa
               :load "ruby-mode.el"
               :after (lambda () (load "config/modes/ruby")))

        ;; javascript related packages
        (:name coffee-mode)
        (:name jade-mode
               :type git
               :url "https://github.com/brianc/jade-mode.git")
        (:name js2-mode
               :type git
               :url "https://github.com/mooz/js2-mode.git")

        ;; clojure related packages
        (:name clojure-mode
               :type elpa
               :load "clojure-mode.el")
        (:name slime
               :type elpa
               :load "slime.el")
        (:name slime-repl
               :type elpa
               :load "slime-repl.el")
        (:name paredit
               :type elpa
               :load "paredit.el")

        ;; css packages
        (:name css-check
               :type http
               :url "https://github.com/pft/elisp-assorted/raw/master/css-check.el"
               :load "css-check.el")

        )
      )

; Do this sync, so required packages are installed and loaded before running
(el-get 'sync)
