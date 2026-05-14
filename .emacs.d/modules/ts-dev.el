;; -*- lexical-binding: t; -*-

(message "Loading ts-dev.el...")


(use-package multiple-cursors
  :ensure t
  :bind (("C->" . mc/mark-next-like-this)
	 ("C-<" . mc/mark-previous-like-this)))


(use-package vterm
    :ensure t)


(use-package eglot
  :disabled
  :ensure t
  :defer t
  :hook (python-mode . eglot-ensure))


;; bazel mode
(use-package bazel
  :ensure t)

;; modelica mode (from https://github.com/modelica-tools/modelica-mode.git)
(use-package modelica-mode
  :load-path "~/.dotfiles/.emacs.d/elisp/"
  :commands (modelica-mode)
  :mode ("\\.mo\\'" . modelica-mode))


;(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(use-package lsp-mode
  :ensure t
  :custom
  (lsp-completion-provider :none) ;; we use Corfu!
  :init
  (defun my/lsp-mode-setup-completion ()
    (setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
          '(orderless))) ;; configure orderless
  :commands lsp
   :hook
  (lsp-completion-mode . my/lsp-mode-setup-completion))

(use-package ccls
  :ensure t
  :hook ((c-mode c++-mode) . (lambda () (require 'ccls) (lsp)))
  :config
  (setq ccls-executable "/usr/bin/ccls"))


;  :hook ((c-mode c++-mode) . (lambda () (require 'ccls) (lsp)))
;  :config (ccls-executable "/usr/bin/ccls"))

(provide 'ts-dev)
