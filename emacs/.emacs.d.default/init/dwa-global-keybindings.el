(require 'dwa-navigation)

(bind-key* [(control return)] 'other-window)
(bind-key* [(control shift return)] 'dwa/other-window-backward)

(provide 'dwa-global-keybindings)
