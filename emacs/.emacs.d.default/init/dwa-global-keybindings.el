;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Define a minor mode for all my global, non-overridable keybindings.
;; Major modes will not generally be able to override these bindings
;; on you.  Thanks to Scott Frazer for this wonderful and simple hint
;; (http://stackoverflow.com/questions/683425/globally-override-key-binding-in-emacs)
(defvar dwa/global-key-map (make-sparse-keymap) "Keymap for dwa/global-key-mode.")

(define-minor-mode dwa/global-key-mode
  "A minor mode so that my key settings override annoying major modes."
  :init-value t
  ;; explicitly keep this out of the mode line
  :lighter ""
  :keymap dwa/global-key-map
)
(dwa/global-key-mode 1)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Try to keep the keymap at the front of `minor-mode-map-alist', preventing packages like Magit
;; from overriding my keys. Proposed by @phils in https://stackoverflow.com/a/5340797/125349
(add-hook 'after-load-functions 'dwa/global-keys-have-priority)
(defun dwa/global-keys-have-priority (_ignored-file)
  "Try to ensure that my keybindings retain priority over other minor modes.

Called via the `after-load-functions' special hook."
  (unless (eq (caar minor-mode-map-alist) 'dwa/global-key-mode)
    (let ((mykeys (assq 'dwa/global-key-mode minor-mode-map-alist)))
      (assq-delete-all 'dwa/global-key-mode minor-mode-map-alist)
      (add-to-list 'minor-mode-map-alist mykeys))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Define the bindings
(require 'dwa-navigation)

(define-key dwa/global-key-map [(control return)] 'other-window)
(define-key dwa/global-key-map [(control shift return)] 'dwa/other-window-backward)

(provide 'dwa-global-keybindings)
