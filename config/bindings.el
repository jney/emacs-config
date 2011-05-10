;; Return always indents
(define-key global-map (kbd "RET") 'newline-and-indent)

;; some deletion
(global-set-key [backspace] 'jney-backward-delete-rectangle-or-region-or-char)
(global-set-key [(control backspace)] 'backward-kill-word)
(global-set-key [(super backspace)] 'jney-backward-kill-line)
(global-set-key [(super shift k)] 'jney-delete-line)

;; some navigation
(global-set-key [(super down)] 'end-of-buffer)
(global-set-key [(super left)] 'beginning-of-line-text)
(global-set-key [(super right)] 'end-of-line)
(global-set-key [(super up)] 'beginning-of-buffer)

;; deals with buffer
(global-set-key [(super w)] 'kill-buffer-and-window)
(global-set-key [(super b)] 'anything-for-buffers)
(global-set-key [(super shift s)] 'jney-rename-file-and-buffer)

;; copy
(global-set-key [(super shift c)] 'jney-copy-current-line)
(global-set-key [(super d)] 'jney-duplicate-line)

;; empty lines à la vim
(global-set-key [(super shift o)] 'jney-create-line-above)
(global-set-key [(super o)] 'jney-create-line-below)

;; move current line
(global-set-key [(control super down)] 'jney-move-one-line-downward)
(global-set-key [(control super up)] 'jney-move-one-line-upward)

;; tabbar
(global-set-key [(super t)] 'jney-tabbar-new-tab)
(global-set-key [(super return)] 'jney-toggle-fullscreen)
(global-set-key [(control tab)] 'tabbar-forward-tab)
(global-set-key [(control shift tab)] 'tabbar-backward-tab)

;; magit
(global-set-key [(control shift g)] 'magit-status)

