;;; package --- 项目管理
;;; Commentary:
;;; Code:


;; 项目管理
(use-package projectile
  :init (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("s-p" . projectile-command-map)
              ("C-c p" . projectile-command-map)))

(use-package helm-projectile
  :custom
  (helm-projectile-sources-list '(helm-source-projectile-buffers-list
                                  helm-source-projectile-recentf-list
                                  helm-source-projectile-files-list
                                  helm-source-projectile-projects))
  :bind
  ("C-x f" . helm-projectile)
  :hook
  (projectile-mode . helm-projectile-on))

(use-package treemacs
  :custom
  (treemacs-width 20)
  :bind
  ("M-0" . treemacs-select-window))

(use-package treemacs-projectile
  :after treemacs projectile)

;; 工作区
(use-package perspective
  :bind ("C-x C-b" . persp-list-buffers)
  :custom
  (persp-initial-frame-name "Main")
  :config
  (persp-mode))


(provide 'project)
;;; project ends here
