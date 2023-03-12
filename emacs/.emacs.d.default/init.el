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
(custom-set-variables
 '(straight-use-package-by-default t))

(use-package diminish)

; (use-package
