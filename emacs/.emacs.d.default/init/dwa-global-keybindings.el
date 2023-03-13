(require 'dwa-navigation)
(require 'dwa-buffers)
(require 'dwa-compile)
(require 'dwa-folding)

;; Prepare the keymap for my globally-overriding bindings.
(unless overriding-terminal-local-map
  (setq overriding-terminal-local-map (make-sparse-keymap)))

(defmacro dwa/global-key (key-name command &optional predicate)
  "Bind KEY-NAME to COMMAND in `overriding-terminal-local-map'.

Forwards its arguments to `bind-key', which see."
  `(bind-key ,key-name ,command overriding-terminal-local-map ,predicate))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Bindings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Window navigation
(dwa/global-key [(control return)] 'other-window)
(dwa/global-key "C-x C-n" 'other-window)
(dwa/global-key [(control shift return)] 'dwa/other-window-backward)
(dwa/global-key "C-x C-p" 'dwa/other-window-backward)

;; Navigation by words
(dwa/global-key [(control ?,)] 'backward-word)
(dwa/global-key [(control ?.)] 'forward-word)

;; Beginning/end of buffer.  The defaults for these seem to be beginning/end of line.
(dwa/global-key [home] 'beginning-of-buffer)
(dwa/global-key [end] 'end-of-buffer)

;; Normally set to bring up a buffer list, but there are many other
(dwa/global-key "\C-x\C-b" 'dwa/other-buffer)
(dwa/global-key "\C-x\C-k" 'dwa/kill-current-buffer)

(dwa/global-key "\C-x\C-g" 'goto-line)

;; Compilation
(dwa/global-key [f7] 'dwa/recompile)
(dwa/global-key [(control f7)] 'dwa/compile)
(dwa/global-key [f4] 'next-error)
(dwa/global-key [(shift f4)] 'previous-error)
(dwa/global-key [(control f4)] 'first-error)

;; Help
(dwa/global-key [(control ?h) ?M] 'man)
(defvar dwa/help-map)
(define-prefix-command 'dwa/help-map)
(dwa/global-key [(control ?h) ?e] 'dwa/help-map)
(dolist (b '((e view-echo-area-messages)
	     (f find-function)
	     (d describe-symbol)
	     (k find-function-on-key)
	     (l find-library)
             (m man)
	     (o customize-option)
	     (g customize-group)
	     (s scratch)
	     (v find-variable)
	     ))
  (bind-key (symbol-name (car b)) (cadr b) dwa/help-map))

;; Folding by indentation (selective display)
(dwa/global-key "C-M-." 'dwa/increase-selective-display)
(dwa/global-key "C-M-," 'dwa/decrease-selective-display)

(dwa/global-key "C-x v e" 'ediff-revision)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Unbindings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when window-system
  (global-unset-key [(control ?z)]) ; suspend-frame
  (global-unset-key [f11]) ; toggle-frame-fullscreen
)
(global-unset-key [(control ?\\)]) ; toggle-input-method
(global-unset-key [f10]) ; menu-bar-open

(provide 'dwa-global-keybindings)
