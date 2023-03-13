;;; dwa-global-config.el ---                         -*- lexical-binding: t; -*-

;; Copyright (C) 2023  Dave Abrahams

;; Author: Dave Abrahams <dave@boostpro.com>
;; Keywords:

;;; Commentary: config that's more than just keybinding, and affects the overall emacs experience.

;; Config not related to any particular package
(use-package emacs
  :config
  (prefer-coding-system 'utf-8)
  (set-variable 'ring-bell-function 'ignore)
  ;; Show the buffer name instead of something like <buffer name> Gnu Emacs at <machine name>
  (set-variable 'frame-title-format '("%b"))
  :custom
  ;; Answer questions with y or n. Emacs officially recommends against this setting.
  (use-short-answers t)
  )

;; Start the server, suppressing warnings
(use-package server
  :config
  (let ((warning-minimum-level :error)) (server-mode)))

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

(use-package ffap
  :bind (("C-x C-f" . find-file-at-point)))

;; Paired delimiters
(use-package skeleton
  :config
  (set-variable 'skeleton-pair t)
  (set-variable 'skeleton-pair-on-word t)

  ;; There's a lot of markdown in everything these days, so pair backquotes by default
  (set-variable 'skeleton-pair-alist
		(cons '(?` _ ?`) skeleton-pair-default-alist))

  ;; Then undo pairings where necessary
  (defun dwa/prepend-local-skeleton-pairs (pairs)
    (set-variable 'skeleton-pair-alist (append pairs skeleton-pair-alist) :make-local))

  (add-hook 'emacs-lisp-mode-hook
	    (lambda () (dwa/prepend-local-skeleton-pairs '((?` _ ?') (?\')))))
  (add-hook 'lisp-interaction-mode-hook
	    (lambda () (dwa/prepend-local-skeleton-pairs '((?` _ ?') (?\')))))
  (add-hook 'tex-mode-hook
	    (lambda () (dwa/prepend-local-skeleton-pairs '((?` _ ?')))))

  :bind (("(" . 'skeleton-pair-insert-maybe)
	 ("[" . 'skeleton-pair-insert-maybe)
	 ("{" . 'skeleton-pair-insert-maybe)
	 ("«" . 'skeleton-pair-insert-maybe)
	 ("`" . 'skeleton-pair-insert-maybe)
	 ("\"" . 'skeleton-pair-insert-maybe))
  )

(provide 'dwa-global-config)
;;; dwa-global-config.el ends here
