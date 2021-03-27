;;; package --- 查找相关
;;; Commentary:
;;; Code:


;; 检索
(use-package helm
  :custom
  (helm-M-x-always-save-history t)
  (savehist-additional-variables '(extended-command-history))
  (history-delete-duplicates t)
  (helm-command-prefix-key nil)
  :bind
  (("M-x" . helm-M-x)
   ("C-x C-f" . helm-find-files)
   ("C-x C-b" . helm-buffers-list)
   ("C-x b" . helm-buffers-list)
   ("C-x C-r" . helm-recentf)
   ("C-x C-i" . helm-imenu)
   ("C-x C-j" . helm-imenu)
   ("M-y" . helm-show-kill-ring))
  :hook
  (dashboard-after-initialize . helm-mode)
  (helm-mode . savehist-mode))

;; helm 按键绑定
(use-package helm-descbinds
  :commands helm-descbinds)

;; helm 悬浮
(use-package helm-posframe
  :straight (:host github :repo "KaratasFurkan/helm-posframe")
  :after helm
  :custom
  (helm-display-header-line nil)
  (helm-echo-input-in-header-line t)
  (helm-posframe-border-color "gray")
  (helm-posframe-parameters '((left-fringe . 5)
                              (right-fringe . 5)))
  :config
  (helm-posframe-enable)
  (remove-hook 'delete-frame-functions 'helm--delete-frame-function))


;; 查找显示
(use-package helm-swoop
  :custom
  (helm-swoop-speed-or-color t)
  (helm-swoop-split-window-function 'display-buffer)
  (helm-swoop-min-overlay-length 0)
  :bind
  (("M-s" . helm-swoop)
   :map isearch-mode-map
   ("M-s" . helm-swoop-from-isearch)
   :map helm-swoop-map
   ("M-s" . helm-multi-swoop-all-from-helm-swoop)
   :map helm-swoop-edit-map
   ("C-c C-c" . helm-swoop--edit-complete)
   ("C-c C-k" . helm-swoop--edit-cancel)))

;; 检索
(use-package helm-ag
  :custom
  (helm-ag-base-command
   "rg -S --no-heading --color=never --line-number --max-columns 400"))

;; 高亮查找
(use-package anzu
  :after isearch
  :config
  (global-anzu-mode))

;; 用rg查找
(use-package deadgrep
  :commands deadgrep
  :bind
  ( :map deadgrep-mode-map
    ("C-c C-e" . deadgrep-edit-mode)))


;; 方法跳转
(use-package xref
  :custom
  (xref-prompt-for-identifier nil)
  :bind
  ("C-M-j" . xref-find-definitions)
  ("C-M-k" . xref-pop-marker-stack)
  ("C-9" . xref-find-definitions)
  ("C-8" . xref-pop-marker-stack)
  ("C-M-S-j" . xref-find-definitions-other-window)
  ("C-M-9" . xref-find-definitions-other-window)
  ("C-M-r" . xref-find-references))

(use-package helm-xref
  :after helm xref)

(use-package dumb-jump
  :custom
  (dumb-jump-aggressive t))


(use-package avy
  :bind
  (("M-j" . avy-goto-word-or-subword-1)
   ("C-M-u" . avy-pop-mark)))



(provide 'search)
;;; search ends here
