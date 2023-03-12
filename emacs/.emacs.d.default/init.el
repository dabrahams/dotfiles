;;; init.el --- Main emacs configuration -*- lexical-binding: t -*-

;; Show the buffer name instead of something like <buffer name> Gnu Emacs at <machine name>
(setq frame-title-format '("### %b ###"))

(setq ring-bell-function 'ignore)

;; Living dangerously: Emacs officially recommends against this
;; setting because I'm supposed to take my time and think about an
;; answer.
(setq use-short-answers t)

;; Package configuration thing
(straight-use-package 'use-package)

;; Use straight to install/load everything that I invoke `use-package' on.
(custom-set-variables '(straight-use-package-by-default t))

;; To keep some minor modes out of the mode line.
;; (use-package diminish)

(dolist (path '("init" "lib"))
  (add-to-list 'load-path (locate-user-emacs-file path)))

(require 'dwa-global-keybindings)


;; packages
(use-package modus-themes)
