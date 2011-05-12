(autoload 'tabbar-mode "tabbar" "" t)
(tabbar-mode 1)
(require 'tabbar-ruler)

(setq tabbar-buffer-groups-function
      (lambda ()
        (list "All Buffers")))
(setq tabbar-buffer-list-function
     	(lambda ()
     	  (remove-if
     	   (lambda(buffer)
     	     (find (aref (buffer-name buffer) 0) " *"))
     	   (buffer-list))))
