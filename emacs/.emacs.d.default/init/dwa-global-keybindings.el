(require 'dwa-navigation)

;; Undo built-in annoyances
(when window-system
  (global-unset-key [(control ?z)]) ; suspend-frame
  (global-unset-key [f11]) ; toggle-frame-fullscreen
)
(global-unset-key [(control ?\\)]) ; toggle-input-method
(global-unset-key [f10]) ; menu-bar-open


;;(bind-key* [(control return)] 'other-window)
;;(bind-key* [(control shift return)] 'dwa/other-window-backward)

(unless overriding-terminal-local-map
  (setq overriding-terminal-local-map (make-sparse-keymap)))

(define-key overriding-terminal-local-map [(control return)] 'other-window)
(define-key overriding-terminal-local-map [(control shift return)] 'dwa/other-window-backward)

;; Navigation by words
(bind-key* [(control ?,)] 'backward-word)
(bind-key* [(control ?.)] 'forward-word)

(provide 'dwa-global-keybindings)
