(require 'erc)

;;;_ + erc

(eval-after-load 'frame-bufs
  (quote
   (push '(iff (eq major-mode 'erc-mode)
               (string= (frame-parameter frame 'name) "Chat"))
         frame-bufs-assoc-rules)))

;; (add-hook 'erc-mode-hook 'frame-bufs-enforce-rules)

;;;###autoload
(autoload 'dwa/irc "erc" "" t)
(defun dwa/irc ()
  (interactive)
  (erc :server "irc.freenode.net" :port 6667 :nick "dabrhams" :password
       (cdr (assoc "bewst" (cadr (assq 'freenode erc-nickserv-passwords)))))
  (erc :server "irc.oftc.net" :port 6667 :nick "dabrahams"))

;;;###autoload
(autoload 'dwa/im "erc" "" t)
(defun dwa/im ()
  (interactive)
  (erc :server "localhost" :port 6667 :nick "dave" :password
       (cdr (assoc "dave" (cadr (assq 'BitlBee erc-nickserv-passwords))))))

;;;###autoload
(autoload 'chat "erc" "" t)
(defun chat ()
  (interactive)
  (if 'use-elscreen
      (progn
        (let ((found (rassoc "Chat" (elscreen-get-screen-to-name-alist))))
          (elscreen-goto (car found))
          (elscreen-create)
          (elscreen-screen-nickname "Chat")))

    (let ((found
           (find-if
            (lambda (frame) (string= "Chat" (frame-parameter frame 'name))) (frame-list))))
      (if found
          (select-frame-set-input-focus found)
        (new-frame '((name . "Chat"))))))
  (dwa/irc)
  (dwa/im))

;;;###autoload
(autoload 'erc-tiny-frame "erc" "" t)
(defun erc-tiny-frame ()
  (interactive)
  (with-selected-frame
      (make-frame '((width                . 80)
                    (height               . 22)
                    (left-fringe          . 0)
                    (right-fringe         . 0)
                    (vertical-scroll-bars . nil)
                    (unsplittable         . t)
                    (has-modeline-p       . nil)
                    (background-color     . "grey80")
                    (minibuffer           . nil)))
    (switch-to-buffer "#emacs")
    (set (make-local-variable 'mode-line-format) nil)))

(defcustom erc-active-unselected-fringe-color "blue"
  "Color used for the background of inactive windows with new messages."
  :type 'color
  :group 'erc)

(defcustom erc-active-unselected-idle-time 120
  "If idle this many seconds, also highlight buffers with new input."
  :type 'integer
  :group 'erc)

(defcustom erc-priority-people-regexp ".*"
  "Regexp that matches BitlBee users you want active notification for."
  :type 'regexp
  :group 'erc)

(defcustom erc-growl-noise-regexp "\\(Logging in:\\|Signing off\\)"
  "Regexp that matches BitlBee users you want active notification for."
  :type 'regexp
  :group 'erc)

(defvar growlnotify-command (executable-find "growlnotify")
   "The path to growlnotify")

(copy-face 'fringe 'erc-active-unselected-old-fringe-face)

(defun restore-default-fringe ()
  (copy-face 'erc-active-unselected-old-fringe-face 'fringe))
 
(defun erc-colorize-active-unselected-buffer ()
  (set-face-background 'fringe erc-active-unselected-fringe-color)
  (add-hook 'post-command-hook 'restore-default-fringe nil t))

(defun my-erc-growl (title message)
  "Shows a message through the growl notification system using
 `growlnotify-command` as the program."
  (cl-flet ((encfn (s) (encode-coding-string s (keyboard-coding-system))) )
    (let* ((process (start-process "growlnotify" nil
                                   growlnotify-command
                                   (encfn title)
                                   "-a" "Emacs"
                                   "-n" "Emacs")))
      (process-send-string process (encfn message))
      (process-send-string process "\n")
      (process-send-eof process)))
  t)

(defun my-erc-hook (&optional match-type nick message)
  "Shows a growl notification, when user's nick was mentioned.
If the buffer is currently not visible, makes it sticky."
  (let ((wind (get-buffer-window))
        (priority-p
         (string-match (concat "\\`[^&]" erc-priority-people-regexp
                               "@BitlBee\\'")
                       (erc-format-target-and/or-network))))
    (if wind
        (if (and priority-p
                 (or (not (eq wind (selected-window)))
                     (and (current-idle-time)
                          (> (float-time (current-idle-time))
                             erc-active-unselected-idle-time))))
            (erc-colorize-active-unselected-buffer))
      (if message
          (unless (or (string-match "^\\** *Users on #" message)
                      (string-match erc-growl-noise-regexp message))
            (my-erc-growl (concat "ERC: " (buffer-name)) message))
        (goto-char (point-min))
        (let ((nick (and (looking-at "<\\([^>]+?\\)>\\s-*")
                         (prog1
                             (match-string 1)
                           (goto-char (match-end 0))))))
          (when priority-p
            (erc-colorize-active-unselected-buffer)
            (my-erc-growl (if nick
                       (format "ERC <%s>" nick)
                     "ERC")
                   (buffer-substring (point) (point-max)))))))))

(add-hook 'erc-text-matched-hook 'my-erc-hook)
(add-hook 'erc-insert-modify-hook 'my-erc-hook)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(erc-anonymous-login t)
 '(erc-auto-query 'window-noselect)
 '(erc-autoaway-message "I'm away (after %i seconds of idle-time)")
 '(erc-autoaway-mode t)
 '(erc-autojoin-channels-alist
   '(("localhost")
     ("freenode.net")))
 '(erc-autojoin-mode t)
 '(erc-default-sound "~/erc.wav")
 '(erc-generate-log-file-name-function 'erc-generate-log-file-name-short)
 '(erc-growl-noise-regexp
   "\\(Logging in:\\|Signing off\\|You're now away\\|Welcome Back\\)")
 '(erc-header-line-format nil)
 '(erc-hide-list
   '("JOIN" "NICK" "PART" "QUIT" "MODE"))
 '(erc-interpret-mirc-color t)
 '(erc-keywords
   '("dave" "abrahams" "JohnWiegley" "boost"))
 '(erc-log-channels-directory "~/Library/Data/ERC")
 '(erc-log-write-after-send t)
 '(erc-modules
   '(autoaway autojoin completion dcc fill identd irccontrols list log match menu move-to-prompt netsplit networks noncommands readonly replace ring scrolltobottom services smiley stamp spelling))
 '(erc-nick "dabrahams")
 '(erc-notify-mode t)
 '(erc-port 6667)
 '(erc-prompt-for-nickserv-password nil)
 '(erc-replace-alist
   '(("</?FONT>" . "")))
 '(erc-server "irc.freenode.net")
 '(erc-services-mode t)
 '(erc-sound-mode t)
 '(erc-track-enable-keybindings t)
 '(erc-track-exclude-types
   '("JOIN" "KICK" "NICK" "PART" "QUIT" "MODE" "333" "353"))
 '(erc-track-faces-priority-list
   '(erc-error-face
     (erc-nick-default-face erc-current-nick-face)
     erc-current-nick-face erc-keyword-face
     (erc-nick-default-face erc-pal-face)
     erc-pal-face erc-nick-msg-face erc-direct-msg-face))
 '(erc-track-minor-mode t)
 '(erc-track-mode t)
 '(erc-user-full-name 'user-full-name))
