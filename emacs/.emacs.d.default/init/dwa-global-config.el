;;; dwa-global-config.el ---                         -*- lexical-binding: t; -*-

;; Copyright (C) 2023  Dave Abrahams

;; Author: Dave Abrahams <dave@boostpro.com>
;; Keywords:

;;; Commentary: config that's more than just keybinding, and affects the overall emacs experience.

;; To keep some minor modes out of the mode line.
(use-package diminish)

;; Remove trailing whitespace on lines I modify, but leave the rest alone.
(use-package ws-butler
 :diminish ;; keep wb out of the mode line.
 :config (ws-butler-global-mode 1))

(use-package modus-themes
  :bind (("<f5>" . 'modus-themes-toggle))
  ; :demand ; override the bind because we want to load the theme
  :init (load-theme 'modus-operandi-tinted :no-confirm))

(provide 'dwa-global-config)
;;; dwa-global-config.el ends here
