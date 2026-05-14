;;; -- Set up package.el and use-package -----

(message "Loading ts-package.el...")

(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))


(setq package-user-dir "~/.dotfiles/.emacs.d/packages")

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)

(provide 'ts-package)
