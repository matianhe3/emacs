;;; project.el --- 项目管理
;;; Commentary:
;;; Code:


;; 项目管理
(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :demand t
  :bind-keymap ("C-c p" . projectile-command-map))

(use-package counsel-projectile
  :after projectile
  :bind (("C-M-p" . counsel-projectile-find-file))
  :config
  (counsel-projectile-mode))

;; 工作区
(use-package perspective
  :bind ("C-x C-b" . persp-list-buffers)
  :custom
  (persp-initial-frame-name "Main")
  :config
  (persp-mode))


(provide 'project)
;;; project ends here
