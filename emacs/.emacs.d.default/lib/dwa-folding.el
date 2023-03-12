;;; dwa-folding.el ---                               -*- lexical-binding: t; -*-

;; Copyright (C) 2023  Dave Abrahams

;; Author: Dave Abrahams <dave@boostpro.com>
;; Keywords:

(defun dwa/increase-selective-display(&optional arg)
  (interactive "p")
  (interactive)
  (set-selective-display
   (+ (or selective-display 0) (or arg 1))))

(defun dwa/decrease-selective-display(&optional arg)
  (interactive "p")
  (when (and (numberp selective-display) (> selective-display 0))
    (set-selective-display
     (max 0
      (- selective-display (or arg 1))))))

;; Make sure the ellipsis indicating collapsed selective-display shows
;; up in "highlight" face so we can see it
(set-display-table-slot standard-display-table 'selective-display
 (let ((highlight-dot (make-glyph-code ?. 'highlight)))
   (make-vector 3 highlight-dot))
 )


(provide 'dwa-folding)
;;; dwa-folding.el ends here
