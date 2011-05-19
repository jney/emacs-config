;; Return always indents
(define-key global-map (kbd "RET") 'newline-and-indent)

;; some deletion
(global-set-key [backspace] 'jney/backward-delete-rectangle-or-region-or-char)
(global-set-key [(alt backspace)] 'backward-kill-word)
(global-set-key [(control shift k)] 'jney/backward-kill-line)
(global-set-key [(super backspace)] 'jney/backward-kill-line)
(global-set-key [(super shift k)] 'jney/delete-line)

;; some navigation
(global-set-key [(super down)] 'end-of-buffer)
(global-set-key [(super left)] 'beginning-of-line-text)
(global-set-key [(super right)] 'end-of-line)
(global-set-key [(super up)] 'beginning-of-buffer)
(global-set-key [(alt left)] 'backward-word)
(global-set-key [(alt right)] 'forward-word)

;; replace
(global-set-key [(super r)] 'replace-regexp)
(global-set-key [(control *)] 'jney/isearch-forward-at-point)

;; deals with buffer
(global-set-key [(super w)] 'jney/close-tab)
(global-set-key [(super b)] 'anything-for-buffers)
(global-set-key [(super shift s)] 'jney/rename-file-and-buffer)

;; copy
(global-set-key [(super shift c)] 'jney/copy-current-line)
(global-set-key [(super d)] 'jney/duplicate-line)

;; empty lines à la vim
(global-set-key [(super shift o)] 'jney/create-line-above)
(global-set-key [(super o)] 'jney/create-line-below)

;; move current line
(global-set-key [(control super down)] 'jney/move-text/down)
(global-set-key [(control super up)] 'jney/move-text/up)

;; nav
(global-set-key [(super n)] 'jney/toggle-nav)

;; tabbar
(global-set-key [(super t)] 'jney/tabbar-new-tab)
(global-set-key [(super return)] 'jney/toggle-fullscreen)
(global-set-key [(super alt left)] 'jney/go-to-bar-or-buffer/previous)
(global-set-key [(super alt right)] 'jney/go-to-tab-or-buffer/next)

;; magit
(global-set-key [(control shift g)] 'magit-status)

;; indent
(global-set-key [(super control left)] 'textmate-shift-left)
(global-set-key [(super control right)] 'textmate-shift-right)

;;
(global-set-key [(super +)] 'jney/change-num-at-point/+)
(global-set-key [(super -)] 'jney/change-num-at-point/-)

;; rebinding center-line
(global-set-key [(super =)] 'center-line)










