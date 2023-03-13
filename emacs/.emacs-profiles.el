;; invoke emacs --with-profile old to get the old profile, for example.
(("default" .
  ((user-emacs-directory . "~/.emacs.d.default")
   (straight-p . t)
   ))

 ("old" . ((user-emacs-directory . "~/.emacs.d.old")
           (server-name . "old")
           ))
)
