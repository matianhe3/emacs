;;; package --- 文件相关
;;; Commentary:
;;; Code:


(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))


;; 文件树
(use-package dired-subtree
  :after dired
  :custom
  (dired-subtree-use-backgrounds nil)
  :bind
  ( :map dired-mode-map
    ("TAB" . dired-subtree-toggle)
    ("<tab>" . dired-subtree-toggle))
  :config
  ;; Fix "no icons in subtree" issue.
  (defadvice dired-subtree-toggle
      (after add-icons activate) (revert-buffer)))

;; 侧边栏
(use-package dired-sidebar
  :commands dired-sidebar-toggle-sidebar
  :hook
  (dired-sidebar-mode . darken-background)
  :config
  (defun sidebar-toggle ()
    "Toggle both `dired-sidebar' and `ibuffer-sidebar'."
    (interactive)
    (dired-sidebar-toggle-sidebar)
    (ibuffer-sidebar-toggle-sidebar)))


(use-package ibuffer-sidebar
  :commands ibuffer-sidebar-toggle-sidebar
  :bind
  ( :map ibuffer-mode-map
    ("M-o" . nil)))

(use-package dired-posframe
  :straight (:host github :repo "conao3/dired-posframe.el")
  :commands dired-posframe-mode)

(provide 'file)
;;; file.el ends here
