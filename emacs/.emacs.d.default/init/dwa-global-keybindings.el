(require 'dwa-navigation)

;; Prepare the keymap for my globally-overriding bindings.
(unless overriding-terminal-local-map
  (setq overriding-terminal-local-map (make-sparse-keymap)))

(defmacro dwa/global-key (key-name command &optional predicate)
  "Bind KEY-NAME to COMMAND in `overriding-terminal-local-map'.

Forwards its arguments to `bind-key', which see."
  `(bind-key ,key-name ,command overriding-terminal-local-map ,predicate))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Bindings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(dwa/global-key [(control return)] 'other-window)
(dwa/global-key [(control shift return)] 'dwa/other-window-backward)

;; Navigation by words
(dwa/global-key [(control ?,)] 'backward-word)
(dwa/global-key [(control ?.)] 'forward-word)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Unbindings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when window-system
  (global-unset-key [(control ?z)]) ; suspend-frame
  (global-unset-key [f11]) ; toggle-frame-fullscreen
)
(global-unset-key [(control ?\\)]) ; toggle-input-method
(global-unset-key [f10]) ; menu-bar-open

(provide 'dwa-global-keybindings)
