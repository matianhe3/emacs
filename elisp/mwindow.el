;;; mwindow.el --- 窗口管理
;;; Commentary:
;;; Code:

(use-package ace-window
  :bind
  ("M-o" . ace-window)
  :custom
  (aw-scope 'frame)
  (aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (aw-minibuffer-flag t)
  :config
  (ace-window-display-mode 1))


(use-package default-text-scale
  :defer 1
  :config
  (default-text-scale-mode))


(provide 'mwindow)
;;; mwindow ends here
