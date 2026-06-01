;; -*- lexical-binding: t; -*-

(message "Loading init.el file...")

(defvar ts/init-file-directory
  (file-name-directory (or load-file-name (buffer-file-name)))
  "The directory from where this init file was loaded.")

(defvar ts/modules-directory
  (concat ts/init-file-directory "modules")
  "The directoty where `modules' are located.")

;; Add configuration modules to load path
(add-to-list 'load-path ts/modules-directory)

(defvar ts/fixed-pitch-font "JetBrains Mono"
  "The font used for `default' and `fixed-pitch' faces.")

(defvar ts/fixed-pitch-size 102)
(message ts/fixed-pitch-font)

(defvar ts/variable-pitch-font "Iosevka Aile"
  "The font used for `variable-pitch' face.")

(defvar ts/variable-pitch-size 120)

(defvar ts/org-heading-font "Iosevka Aile"
  "The font used for Org Mode headings.")


(defvar ts/current-distro (or (and (eq system-type 'gnu/linux)
                                   (file-exists-p "/etc/os-release")
                                   (with-temp-buffer
                                     (insert-file-contents "/etc/os-release")
                                     (search-forward-regexp "^ID=\"?\\(.*\\)\"?$")
                                     (intern (or (match-string 1)
                                                 "unknown"))))
                              'unknown))

;; load modules


(require 'ts-package)
(require 'ts-settings)
(require 'ts-keys)

(setq load-prefer-newer t)
(require 'ts-core)
(require 'ts-interface)
(require 'ts-org)
(require 'ts-dev)
(require 'ts-md)

;; provisory
(use-package rust-mode
  :ensure t)
