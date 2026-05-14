;; -*- lexical-binding: t; -*-

(message "Loading ts-settings.el...")

(defun ts/load-system-settings ()
  (interactive)
  (load-file "~/.dotfiles/.emacs.d/per-system-settings.el"))

(defun ts/system-settings-get (setting)
  (alist-get setting ts/system-settings))

;; Load settings for the first time
(ts/load-system-settings)


(provide 'ts-settings)


