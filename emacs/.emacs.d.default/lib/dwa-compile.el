;;; dwa-compile.el ---                               -*- lexical-binding: t; -*-

;; Copyright (C) 2023  Dave Abrahams

;; Author: Dave Abrahams <dave@boostpro.com>

;;

;;; Code:
;;
;; dwa/compile, dwa/recompile - easy compilation with scrolling errors, and easy
;;      recompilation without worrying about what buffer you're in.
;;

;; Used by dwa/compile and dwa/recompile to get back to the bottom of a
;; compilation buffer after save-excursion brings us back to the place we
;; started.
(defun dwa/end-of-current-compilation-buffer()
  (if (equal (buffer-name) "*compilation*")
      (goto-char (point-max))))

(defun dwa/compile(&optional command)
  (interactive)
  (if (interactive-p)
      (call-interactively 'compile)
    (compile command))
  (save-excursion
    (pop-to-buffer "*compilation*")
    (goto-char (point-max)))
  ;; force scrolling despite save-excursion
  (dwa/end-of-current-compilation-buffer))

(defun dwa/buffer-exists (buffer)
  "Return t if the buffer exists.
buffer is either a buffer object or a buffer name"
  (bufferp (get-buffer buffer)))

(defun dwa/recompile ()
  "Run recompilation but put the point at the *end* of the buffer
so we can watch errors as they come up"
  (interactive)
  (if (and (bufferp (get-buffer "*compilation*"))
           compile-command)
      (save-excursion
        ;; switching to the compilation buffer here causes the compile command to be
        ;; executed from the same directory it originated from.
        (pop-to-buffer "*compilation*")
        (recompile)
        (pop-to-buffer "*compilation*")
        (goto-char (point-max)))
    ;; else
    (call-interactively 'dwa/compile))
  ;; force scrolling despite save-excursion
  (dwa/end-of-current-compilation-buffer))

(provide 'dwa-compile)
;;; dwa-compile.el ends here
