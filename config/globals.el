;; Customize emacs starter kit
(remove-hook 'coding-hook 'pretty-lambdas)

;; Automatically reload files that have been changed outside Emacs
(global-auto-revert-mode t)

;; utf-8 please
(prefer-coding-system 'utf-8)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)

;; Blinking vertical bars are all the cursory rage...
(setq cursor-type 'bar)
(blink-cursor-mode t)

;; use only spaces and no tabs
(setq-default indent-tabs-mode nil)

;; Wrap at 79 chars
(setq-default fill-column 79)

;; Tabs are 2 spaces by default
(setq default-tab-width 2)

;; http://www.masteringemacs.org/articles/2011/10/02/improving-performance-emacs-display-engine/
;; fully redraw the display before it processes queued input events
(setq redisplay-dont-pause t)

;; Can delete a selected region
(delete-selection-mode t)

;; Kill trailing whitespace on save
(add-hook 'before-save-hook (lambda () (delete-trailing-whitespace)))

;; When opening by 'cocoa' (e.g drop on icon) open in existing frame
(setq ns-pop-up-frames nil)

;; reopen last session
(desktop-save-mode 1)

;; font
(setq mac-allow-anti-aliasing t)
(set-face-font 'default "Inconsolata-13")

;; enabling narrowing
(put 'narrow-to-region 'disabled nil)

;; love newline but yasnippet doesn't
(setq require-final-newline nil)

(custom-set-variables '(speedbar-show-unknown-files t))
