;;; dwa-global-config.el ---                         -*- lexical-binding: t; -*-

;; Copyright (C) 2023  Dave Abrahams

;; Author: Dave Abrahams <dave@boostpro.com>
;; Keywords:

;;; Commentary: config that's more than just keybinding, and affects the overall emacs experience.

;; Start the server, suppressing warnings
(let ((warning-minimum-level :error)) (server-mode))

;; To keep some minor modes out of the mode line.
(use-package diminish)

;; Remove trailing whitespace on lines I modify, but leave the rest alone.
(use-package ws-butler
 :diminish ;; keep wb out of the mode line.
 :config (ws-butler-global-mode 1))

(use-package modus-themes
  :bind (("<f5>" . 'modus-themes-toggle))
  :init (load-theme 'modus-operandi-tinted :no-confirm)
  :custom
  (modus-themes-to-toggle '(modus-operandi-tinted modus-vivendi-tinted))
  (modus-themes-italic-constructs t) ; use italics in code (mostly for comments)
  (modus-themes-bold-constructs t)   ; use bold in code.
  (modus-themes-variable-pitch-ui t) ; Variable pitch in my modeline
  )

(prefer-coding-system 'utf-8)

(provide 'dwa-global-config)
;;; dwa-global-config.el ends here
