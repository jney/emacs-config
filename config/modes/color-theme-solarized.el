(when (and (functionp 'color-theme-install) (>= (display-color-cells) 256))
  (if (string-equal (getenv "BACKGROUND") "light")
      (color-theme-solarized-light)
    (color-theme-solarized-dark)))
