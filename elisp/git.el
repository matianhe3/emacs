;;; git.el --- Git相关
;;; Commentary:
;;; Code:


(use-package magit
  :bind ("C-M-;" . magit-status)
  :commands (magit-status magit-get-current-branch)
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package git-link
  :commands git-link
  :config
  (setq git-link-open-in-browser t))

(use-package git-gutter
  :straight git-gutter-fringe
  :diminish
  :hook ((text-mode . git-gutter-mode)
         (prog-mode . git-gutter-mode))
  :config
  (setq git-gutter:update-interval 2))

(setq git-gutter:modified-sign "≡")
(setq git-gutter:added-sign "≡")
(setq git-gutter:deleted-sign "≡")


(provide 'git)
;;; git.el ends here
