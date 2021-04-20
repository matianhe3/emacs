;;; modeline.el --- 状态栏
;;; Commentary:
;;; Code:

(use-package minions
  :hook (doom-modeline-mode . minions-mode))

(use-package doom-modeline
  :init
  ;; show doom-modeline at the same time with dashboard
  (add-hook 'emacs-startup-hook 'doom-modeline-mode -100)
  :custom
  (doom-modeline-buffer-encoding nil)
  (doom-modeline-vcs-max-length 20)
  :custom-face
  (mode-line-highlight ((t (:inherit doom-modeline-bar :foreground "black"))))
  (doom-modeline-buffer-path ((t (:inherit font-lock-comment-face :slant normal))))
  :hook
  (after-init . doom-modeline-init))

(provide 'modeline)
;;; modeline ends here
