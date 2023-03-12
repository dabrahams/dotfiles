(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq use-dialog-box t
      use-file-dialog nil
      inhibit-splash-screen t
      inhibit-startup-screen t
      inhibit-startup-echo-area-message user-login-name ; no, I really don't want the GNU message
      inhibit-startup-buffer-menu t)

;; log any warnings during async native compilation but do not pop up *Warnings* buffer.
(setq native-comp-async-report-warnings-errors 'silent) ; emacs28 with native compilation
