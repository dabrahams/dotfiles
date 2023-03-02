;;; init.el --- Main emacs configuration -*- lexical-binding: t -*-

;; Show the buffer name instead of something like <buffer name> Gnu Emacs at <machine name>
(setq frame-title-format '("%b"))

(setq ring-bell-function 'ignore)

;; Living dangerously: Emacs officially recommends against this
;; setting because I'm supposed to take my time and think about an
;; answer.
(setq use-short-answers t)

;; <leaf-install-code>
(eval-and-compile
  (customize-set-variable
   'package-archives '(("org" . "https://orgmode.org/elpa/")
		       ("melpa" . "https://melpa.org/packages/")
		       ("gnu" . "https://elpa.gnu.org/packages/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :init
    ;; optional packages if you want to use :hydra, :el-get, :blackout,,,
    ;(leaf hydra :ensure t)
    ;(leaf el-get :ensure t)
    ;(leaf blackout :ensure t)

    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))
;; </leaf-install-code>

;; Get parallel installation
(leaf feather :ensure t)
(feather-mode)

(when nil
;; Now you can use leaf!
(leaf leaf-tree :ensure t)
(leaf leaf-convert :ensure t)
(leaf transient-dwim
  :ensure t
  :bind (("M-=" . transient-dwim-dispatch)))

;; You can also configure builtin package via leaf!
(leaf cus-start
  :doc "define customization properties of builtins"
  :tag "builtin" "internal"
  :custom ((user-full-name . "Naoya Yamashita")
	   (user-mail-address . "conao3@gmail.com")
	   (user-login-name . "conao3")
	   (truncate-lines . t)
	   (menu-bar-mode . t)
	   (tool-bar-mode . nil)
	   (scroll-bar-mode . nil)
	   (indent-tabs-mode . nil)))

(leaf autorevert
  :doc "revert buffers when files on disk change"
  :tag "builtin"
  :custom ((auto-revert-interval . 0.1))
  :global-minor-mode global-auto-revert-mode)

;; Nest package configurations
(leaf flycheck
  :doc "On-the-fly syntax checking"
  :emacs>= 24.3
  :ensure t
  :bind (("M-n" . flycheck-next-error)
	 ("M-p" . flycheck-previous-error))
  :custom ((flycheck-emacs-lisp-initialize-packages . t))
  :hook (emacs-lisp-mode-hook lisp-interaction-mode-hook)
  :config
  (leaf flycheck-package
    :doc "A Flycheck checker for elisp package authors"
    :ensure t
    :config
    (flycheck-package-setup))

  (leaf flycheck-elsa
    :doc "Flycheck for Elsa."
    :emacs>= 25
    :ensure t
    :config
    (flycheck-elsa-setup))

  ;; ...
  )

;; ...
)
