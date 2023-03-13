;;; init.el --- Main emacs configuration -*- lexical-binding: t -*-

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

;; Enable `require' for my modules.
(dolist (path '("init" "lib"))
  (add-to-list 'load-path (locate-user-emacs-file path)))

;; Keyboard shortcuts
(require 'dwa-global-keybindings)

;; Other things that affect the overall experience of using emacs
(require 'dwa-global-config)

;; Other things that affect the overall experience of using emacs
(require 'dwa-progmodes)

;; Packages that may or may not get used in a given emacs session
(use-package magit
 :defer t)
