;;; early-init.el --- First file loaded by emacs on startup  -*- lexical-binding: t; -*-

;; Copyright (C) 2023  Dave Abrahams

;; Author: Dave Abrahams <dave@boostpro.com>
;; Keywords:

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq frame-resize-pixelwise t
      frame-inhibit-implied-resize t)

(setq use-dialog-box t
      use-file-dialog nil
      inhibit-splash-screen t
      inhibit-startup-screen t
      inhibit-startup-echo-area-message user-login-name ; no, I really don't want the GNU message
      inhibit-startup-buffer-menu t)

(setq custom-file (concat user-emacs-directory "customizations.el"))

;; Initialise installed packages
(setq package-enable-at-startup t)

(defvar package-quickstart)

;; Allow loading from the package cache
(setq package-quickstart t)

(setq native-comp-async-report-warnings-errors 'silent) ; emacs28 with native compilation

(add-hook 'window-setup-hook 'toggle-frame-maximized t)
(add-hook 'window-setup-hook (lambda () (set-frame-font "Monego-15")))
;;; early-init.el ends here

