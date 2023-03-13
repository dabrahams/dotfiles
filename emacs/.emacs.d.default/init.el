;;; init.el --- Main emacs configuration -*- lexical-binding: t -*-

;; Show the buffer name instead of something like <buffer name> Gnu Emacs at <machine name>
(setq frame-title-format '("### %b ###"))

(setq ring-bell-function 'ignore)

;; Living dangerously: Emacs officially recommends against this
;; setting because I'm supposed to take my time and think about an
;; answer.
(setq use-short-answers t)

(setq
 ;; Use straight to install/load everything that I invoke `use-package' on.
 straight-use-package-by-default t

 ;; cause straight.el to cache the autoloads of all used packages in a single file on disk, and load
 ;; them from there instead of from the individual package files if they are still up to date. This
 ;; reduces the number of disk IO operations during startup from O(number of packages) to O(1), so
 ;; it should improve performance. No other configuration should be necessary to make this work;
 ;; however, you may wish to call straight-prune-build occasionally
 straight-cache-autoloads t
)

;; Package configuration thing
(straight-use-package 'use-package)

(dolist (path '("init" "lib"))
  (add-to-list 'load-path (locate-user-emacs-file path)))

(require 'dwa-global-keybindings)


;; packages
(use-package modus-themes)
(use-package magit)
