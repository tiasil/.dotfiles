;; -*- lexical-binding: t; -*-

(message "Loading ts-keys.el...")

;; -- Key Binding Helpers -----

(defun define-key* (keymap &rest keys)
  "Define multiple keys in a keymap."
  (while keys
    (define-key keymap
                (kbd (pop keys))
                (pop keys))))

(put 'define-key* 'lisp-indent-function 1)

;; -- Files Keymap -----

(defvar ts/files-prefix-map (make-sparse-keymap)
  "Keymap for common file operations.")

(global-set-key (kbd "C-c f") ts/files-prefix-map)


(provide 'ts-keys)
