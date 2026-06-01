;; -*- lexical-binding: t; -*-

(message "Loading ts-md.el...")



(defun ts-md--current-dir ()
  (file-name-directory (or load-file-name buffer-file-name)))

(defvar ts-md--css-cmd-option
  (concat " --css="
	  (expand-file-name "markdown/github-markdown-dark.css" ( ts-md--current-dir))))

(defvar ts-md--template-cmd-option
  (concat " --template="
	  (expand-file-name "markdown/pandoc-html5.template" ( ts-md--current-dir))))
  

;; github style (github flavored markdown - gfm)
;; renderer pandoc
;; default browser brave
(use-package markdown-mode
  :ensure t
  :mode (("\\.md\\'" . gfm-mode))
  :init
  (setq markdown-command
	(concat "/usr/bin/pandoc -f gfm -t html5 --self-contained "
		(concat ts-md--css-cmd-option ts-md--template-cmd-option)))
  (setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "/usr/bin/brave-browser")
  :bind ((:map markdown-mode-map
               ("C-c C-e" . markdown-do))
         (:map gfm-mode-map
               ("C-c C-e" . markdown-do))))


(provide 'ts-md)
