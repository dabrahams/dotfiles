;;; dwa-buffers.el ---                               -*- lexical-binding: t; -*-

;; Copyright (C) 2023  Dave Abrahams

;; Author: Dave Abrahams <dave@boostpro.com>

;;

(defun dwa/kill-current-buffer ()
  "Kill the current buffer without asking, unless it's a modified file, in which case ask first"
  (interactive)
  (kill-buffer (current-buffer)))


(provide 'dwa-buffers)
;;; dwa-buffers.el ends here
