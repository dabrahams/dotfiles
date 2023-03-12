(defun dwa/other-window-backward (&optional n)
  "Select the previous window. Copied from \"Writing Gnu Emacs Extensions\"."
  (interactive "P")
  (other-window (- (or n 1)))
  )

(provide 'dwa-navigation)
