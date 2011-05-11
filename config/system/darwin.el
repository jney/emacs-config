;; disabling option touch as meta
(normal-erase-is-backspace-mode t)
(setq mac-option-key-is-meta nil)
(setq mac-option-modifier 'alt)
;;(setq mac-option-modifier nil)
(setq mac-function-modifier 'meta)
;;
(global-set-key [(alt \()] ( lambda () (interactive) (insert "{") ))
(global-set-key [(alt \))] ( lambda () (interactive) (insert "}") ))
(global-set-key [(alt n)] ( lambda () (interactive) (insert "~") ))
(global-set-key [(alt shift \()] ( lambda () (interactive) (insert "[") ))
(global-set-key [(alt shift \))] ( lambda () (interactive) (insert "]") ))
(global-set-key [(alt shift l)] ( lambda () (interactive) (insert "|") ))
