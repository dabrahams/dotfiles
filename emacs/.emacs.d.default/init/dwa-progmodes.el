;;; dwa-progmodes.el ---                         -*- lexical-binding: t; -*-

;; Copyright (C) 2023  Dave Abrahams

;; Author: Dave Abrahams <dave@boostpro.com>
;; Keywords:

;;; Commentary: config for programming

;; Start the server, suppressing warnings

(add-to-list 'auto-mode-alist
             '("\\.mm\\'" . objc-mode))

(use-package swift-mode
  :mode ("\\.swift\\.gyb" . swift-mode))

(provide 'dwa-progmodes)
;;; dwa-global-config.el ends here
