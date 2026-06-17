;; -*- lexical-binding: t; -*-

(message "Loading ts-md.el...")

(defun ts/md--current-dir ()
  (file-name-directory (or load-file-name buffer-file-name)))

;; Add GitHub Markdown CSS to Pandoc output
;;
;; Defines the Pandoc --css option pointing to a local github-markdown-dark.css,
;; enabling consistent GitHub-style rendering (including layout, typography, and margins)
;; in generated HTML.
;;
;; Note: original github-markdown-dark.css file was changed to display the content
;; at the center of the rendered page:
;;  - padding: 0 16px;
;;  - margin: 40px auto;
;;  - max-width: 1100px;
(defvar ts/md--github-css-cmd-option
  (concat " --css="
	  (expand-file-name "markdown/github-markdown-dark.css" ( ts/md--current-dir))))


;; Custom Pandoc template to enable GitHub Markdown styling
;; 
;; Overrides the default Pandoc HTML template to add class="markdown-body"
;; to the <body> element, allowing correct rendering with GitHub-style
;; CSS (github-markdown.css).
(defvar ts/md--pandoc-template-cmd-option
  (concat " --template="
	  (expand-file-name "markdown/pandoc-html5.template" ( ts/md--current-dir))))

;; Mermaid.js header for rendering diagrams in Pandoc HTML output
;;
;; Adds Mermaid.js via CDN and initializes it with startOnLoad, allowing
;; diagram rendering from normalized <pre class="mermaid"> blocks produced
;; by the Lua filter.
(defvar ts/md--mermaid-include-in-header-cmd-option
  (concat " --include-in-header="
	  (expand-file-name "markdown/mermaid.html" ( ts/md--current-dir))))

;; Pandoc Lua filter to normalize Mermaid code blocks
;;
;; Converts Mermaid fenced code blocks into raw <pre class="mermaid">
;; elements by removing the <code> wrapper introduced by Pandoc,
;; decoding HTML entities, and stripping indentation.
;; Ensures compatibility with Mermaid.js, which requires unescaped,
;; direct text content for correct diagram rendering.
(defvar ts/md--mermaid-lua-filter-cmd-option
  (concat " --lua-filter="
	  (expand-file-name "markdown/mermaid.lua" ( ts/md--current-dir))))

;; Configure Markdown editing and preview workflow
;;
;; Sets up GitHub Flavored Markdown (GFM) mode with Pandoc
;; as the rendering backend and Brave as the default browser
;; for previewing generated HTML.
(use-package markdown-mode
  :ensure t
  :mode (("\\.md\\'" . gfm-mode))
  :init
  (setq markdown-command
	(concat "/usr/bin/pandoc -f gfm -t html5 --self-contained"
		ts/md--github-css-cmd-option
		ts/md--pandoc-template-cmd-option
		ts/md--mermaid-include-in-header-cmd-option
		ts/md--mermaid-lua-filter-cmd-option))
  
  (setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "/usr/bin/brave-browser")
  :bind ((:map markdown-mode-map
               ("C-c C-e" . markdown-do))
         (:map gfm-mode-map
               ("C-c C-e" . markdown-do))))


(provide 'ts-md)
