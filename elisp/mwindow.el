;;; package --- 窗口管理
;;; Commentary:
;;; Code:

(use-package ace-window
  :custom
  (aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (aw-ignore-current t)
  :bind*
  ( :map windows
    ("w" . ace-window)
    ("D" . ace-delete-window)
    ("s" . ace-swap-window))
  :custom-face
  (aw-leading-char-face ((t (:height 1000 :foreground "red")))))

;; 窗口切换
(use-package winum
  :bind*
  ("M-1" . winum-select-window-1)
  ("M-2" . winum-select-window-2)
  ("M-3" . winum-select-window-3)
  ("M-4" . winum-select-window-4)
  ("M-5" . winum-select-window-5)
  ("M-6" . winum-select-window-6)
  ("M-7" . winum-select-window-7)
  ("M-8" . winum-select-window-8)
  ("M-9" . winum-select-window-9)
  :config
  (winum-mode))


(provide 'mwindow)
;;; mwindow ends here
