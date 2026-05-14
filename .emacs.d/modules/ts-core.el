;; -*- lexical-binding: t; -*-

(message "Loading ts-core.el...")


;;; -- Basic Configuration Paths -----

;; Change the user-emacs-directory to ~/.dotfiles/.emacs.d/
;; TODO: create a symlink from ~/.dotfiles/.emacs.d/init.el to the default ~/.emacs.d/init.el
;;
;; #+begin_src sh
;;    mkdir ~/emacs.d
;;    ln -sf ~/.dotfiles/emacs/init.el ~/.emacs.d/
;; #+end_src
;; (setq user-emacs-directory (expand-file-name ts/init-file-directory))

;; Use no-littering to automatically set common paths to the new user-emacs-directory
;; https://github.com/emacscollective/no-littering/tree/main
(use-package no-littering
  :demand t
  :ensure t
  
  :init
  ;; Prepare no-littering variables
  (eval-and-compile ; Ensure values do not differ at compile time
    (setq no-littering-etc-directory
	(expand-file-name ".config/" user-emacs-directory))
    (setq no-littering-var-directory
	  (expand-file-name ".cache/" user-emacs-directory)))

  :config
  ;; Set the custom-file to a file that won't be tracked by Git
  (setq custom-file (no-littering-expand-etc-file-name "custom.el"))
  (when (file-exists-p custom-file)
    (load custom-file))
  
  ;; Set all lockfiles (.#FILE) directory (emacs version >= 28.1)
  ;; Disale lockfiles (emacs version < 28.1)
  ;; https://www.gnu.org/software/emacs/news/NEWS.28.html
  (if (version< emacs-version "28.1")
      (setq create-lockfiles nil)
    (let ((dir (no-littering-expand-var-file-name "lockfiles/")))
      (make-directory dir t)
      (setq lock-file-name-transforms `((".*" ,dir t)))))
  
  ;; Set native compilation cache directory
  (if (not (version< emacs-version "28.1"))
      (add-to-list 'native-comp-eln-load-path (expand-file-name "eln-cache/" no-littering-var-directory)))
  
  ;; Exclude all no-littering files from recentf (if used)
  (with-eval-after-load 'recentf
    (add-to-list 'recentf-exclude
		 (recentf-expand-file-name no-littering-var-directory))
    (add-to-list 'recentf-exclude
		 (recentf-expand-file-name no-littering-etc-directory)))
    
  (no-littering-theme-backups)
)

;;; -- Native Compilation -----

(setq native-comp-async-report-warnings-errors nil) ;; silence compiler warnings as they can be pretty disruptive


;; ;;; -- Basic Emacs Settings -----

(setq initial-scratch-message nil)   ;; no initial-scratch buffer message
(setq inhibit-startup-message t)     ;; disable start-up message

(scroll-bar-mode -1)   ;; disable visible scrollbar
(tool-bar-mode -1)     ;; disable the toolbar
(tooltip-mode -1)      ;; disable tool tip
(set-fringe-mode 10)   ;; give some breathing room line numbers
(menu-bar-mode -1)     ;; disable menu bar

(setq-default fill-column 80)  ;; line-wrapping
(setq visible-bell t)          ;; flash the fram to represent a bell

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))   ;; one line at a time
(setq mouse-wheel-progressive-speed nil)              ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't)                    ;; scroll window under mouse
(setq scroll-step 1)                                  ;; keyboard scroll one line at a time
(setq use-dialog-box nil)                             ;; disable dialog boxes

(set-default-coding-systems 'utf-8)                   ;; use utf-8 by default

;; Set frame transparency
;; https://www.emacswiki.org/emacs/TransparentEmacs

(defun ts/set-frame-transparency (value)
  "Sets the transparency of the frame window (including text)"
  (interactive "alpha:")
  (set-frame-parameter (selected-frame) 'alpha value)
  (add-to-list 'default-frame-alist `(alpha . (,value . ,value))))

(defun ts/set-frame-background-transparency (value)
  "Sets the transparency of the frame window background (excluding text)"
  (interactive "alpha:")
  (set-frame-parameter (selected-frame) 'alpha-background value)
  (add-to-list 'default-frame-alist `(alpha-background . ,value)))


(if (version< emacs-version "29.1")
    (ts/set-frame-transparency 93)
  (ts/set-frame-background-transparency 93))
  

;; Set frame default size
;; https://www.emacswiki.org/emacs/FullScreen
(set-frame-parameter (selected-frame) 'fullscreen 'maximized) ;; frame size mode
(add-to-list 'default-frame-alist '(fullscreen . maximized))


;;; -- Core Key Bindings and Packages -----

;; features

(require 'repeat)
(repeat-mode t)

(require 'recentf)


;;; font defaults

;; set default font face
(set-face-attribute 'default nil
		    :font  (ts/system-settings-get 'emacs/default-fixed-face-font)
		    :height (ts/system-settings-get 'emacs/fixed-face-size)
		    :weight 'normal)


;; set fixed font face
(set-face-attribute 'fixed-pitch nil
                    :font (ts/system-settings-get 'emacs/default-fixed-face-font)
                    :height (ts/system-settings-get 'emacs/fixed-face-size)
		    :weight 'light)


;; set variable font face
(set-face-attribute 'variable-pitch nil
                    :font (ts/system-settings-get 'emacs/default-variable-face-font)
                    :height (ts/system-settings-get 'emacs/variable-face-size)
                    :weight 'normal)

;;; line numbers

;; disable line numbers globaly 
(setq global-display-line-numbers-mode 0)
(column-number-mode) ;; for modeline

;; enable line numbers for listed modes
(dolist (mode '(text-mode-hook
		prog-mode-hook
		conf-mode-hook))
  (add-hook mode (lambda ()
		   (display-line-numbers-mode)
		   (setq display-line-numbers-width 4))))


;; other stuff
(setq large-file-warning-threshold nil)
(setq vc-follow-symlinks t)
(setq ad-redefinition-action 'accept)


;;; locale and clocks

;; for some reason, emacs can't set AM/PM if time locale is different
;; from "en_US.UTF-8"
(setq system-time-locale "en_US.UTF-8")


(setq display-time-format "%l:%M %p %b %d W%U"
      display-time-load-average-threshold nil)

(setq display-time-world-list
      '(("Etc/UTC" "UTC")
        ("Europe/Lisbon" "Portugal")
        ("America/New_York" "Boston")
        ("America/Denver" "Denver")
        ("America/New_York" "New York")
        ("Europe/Berlin" "Munich")
        ("Brazil/East" "Brasília")))

(setq display-time-world-time-format "%a, %d %b %I:%M %p %Z")

;; ;;; Appearance

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

(use-package nerd-icons
  :ensure t
  :if (display-graphic-p))


;; mode line
(use-package doom-modeline
  :ensure t
  :config
  (display-battery-mode 0)
  (display-time-mode 1)
  (doom-modeline-mode 1)
  :custom
  (doom-modeline-height 28)
  (doom-modeline-buffer-file-name-style 'auto)
  (doom-modeline-icon t)
  (doom-modeline-major-mode-icon t)
  (doom-modeline-major-mode-color-icon t)
  (doom-modeline-buffer-state-icon t)
  (doom-modeline-buffer-modification-icon t)
  (doom-modeline-highlight-modified-buffer-name nil)
  (doom-modeline-lsp-icon t)
  (doom-modeline-time t)
  (doom-modeline-time-icon t)
  (doom-modeline-buffer-name t)
  (doom-modeline-minor-modes t)
  (doom-modeline-enable-word-count t)
  (doom-modeline-indent-info t)
  (doom-modeline-total-line-number t)
  (doom-modeline-vcs-icon t))

(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t)
  (doom-themes-visual-bell-config))

(provide 'ts-core)



