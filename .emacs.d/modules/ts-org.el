;; -*- lexical-binding: t; -*-

(message "Loading ts-org.el...")


;; hook setup
(defun ts/org-mode-setup ()
  (org-indent-mode 1)
  (auto-fill-mode 0)
  (visual-line-mode 1)
  (setq corfu-auto nil))


(use-package org
  :hook (org-mode . ts/org-mode-setup)
  :bind (("C-c o n" . org-toggle-narrow-to-subtree)
         ("C-c o a" . org-agenda)
         ("C-c o t" . (lambda ()
                        (interactive)
                        ;; display tasks after selecting tags to filter by
                        (org-tags-view t)))
         ("C-c o c" . 'org-capture)
         ("C-c o x" . 'org-export-dispatch))
  :config
  (setq org-ellipsis " ▾"
        org-hide-emphasis-markers t
        org-src-fontify-natively t
        org-fontify-quote-and-verse-blocks t
        org-src-tab-acts-natively t
        org-edit-src-content-indentation 2
        org-hide-block-startup nil
        org-src-preserve-indentation nil
        org-startup-folded 'content
        org-cycle-separator-lines 2
        org-capture-bookmark nil))


(use-package org-faces
  :ensure nil
  :after org
  :config
  ;; set title font and size
  (set-face-attribute 'org-document-title nil
		      :font (ts/system-settings-get 'emacs/org-variable-face-font)
		      :weight 'medium
		      :height 1.3)

  ;; set font and size of various headings
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil
			:font (ts/system-settings-get 'emacs/org-variable-face-font)
			:weight 'medium
			:height (cdr face))))


(use-package org-bullets
  :ensure t
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(use-package visual-fill-column
  :ensure t
  :hook (org-mode . visual-fill-column-mode)
  :custom
  (visual-fill-column-width 110)
  (visual-fill-column-center-text t))

(provide 'ts-org)
