(require 'map) ;; Needed for map merge

(setq ts/system-settings
      (append
       ;; Put all system-specific settings at the front so that their values are found first

       (when (equal system-name "PT-PF3TZZ4J-LX")
	 '((emacs/default-fixed-face-font . "JetBrains Mono")
	   (emacs/default-variable-face-font . "Iosevka Aile")
	   (emacs/org-fixed-face-font . "JetBrains Mono")
	   (emacs/org-variable-face-font . "Iosevka Aile")
	   (emacs/default-face-size . 110)
	   (emacs/fixed-face-size . 110)
	   (emacs/variable-face-size . 110)))

       '((desktop/dpi . 180)
         (desktop/background . "samuel-ferrara-uOi3lg8fGl4-unsplash.jpg")
         (emacs/default-face-size . 110)
         (emacs/variable-face-size . 120)
         (emacs/fixed-face-size . 110)
         (polybar/height . 35)
         (polybar/font-0-size . 18)
         (polybar/font-1-size . 14)
         (polybar/font-2-size . 20)
         (polybar/font-3-size . 13)
         (dunst/font-size . 20)
         (dunst/max-icon-size . 88))))
