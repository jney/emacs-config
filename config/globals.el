;; Customize emacs starter kit
(remove-hook 'coding-hook 'pretty-lambdas)

;; Automatically reload files that have been changed outside Emacs
(global-auto-revert-mode t)

;; utf-8 please
(prefer-coding-system 'utf-8)

;; Blinking vertical bars are all the cursory rage...
(setq cursor-type 'bar)
(blink-cursor-mode t)

;; use only spaces and no tabs
(setq-default indent-tabs-mode nil)

;; Tabs are 2 spaces by default
(setq default-tab-width 2)

;; Can delete a selected region
(delete-selection-mode t)

;; Decent font choice
(set-frame-font "Meslo LG M DZ-")

;; Wrap at 80 chars
(set-default 'fill-column 80)

;; Kill trailing whitespace on save
(add-hook 'before-save-hook (lambda () (delete-trailing-whitespace)))

;; When opening by 'cocoa' (e.g drop on icon) open in existing frame
(setq ns-pop-up-frames nil)

;; Line numbers
(setq linum-format " %d ")
(global-linum-mode t)

;; reopen last session
(desktop-save-mode 1)

;; font
(setq mac-allow-anti-aliasing t)

