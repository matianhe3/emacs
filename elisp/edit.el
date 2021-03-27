;;; package ---  编辑相关
;;; Commentary:
;;; Code:

;; 多光标
(use-package multiple-cursors
  :custom
  (mc/always-run-for-all t)
  :bind
  (("C-M-n" . mc/mark-next-like-this)
   ("C-M-p" . mc/mark-previous-like-this)
   ("C-M-S-n" . mc/skip-to-next-like-this)
   ("C-M-S-p" . mc/skip-to-previous-like-this)
   ("C-S-n" . mc/unmark-previous-like-this)
   ("C-S-p" . mc/unmark-next-like-this)
   ("C-M-<mouse-1>" . mc/add-cursor-on-click)))


;; 块包围
(use-package wrap-region
  :hook
  (dashboard-after-initialize . wrap-region-global-mode)
  :config
  (wrap-region-add-wrapper "=" "=" nil 'org-mode)
  (wrap-region-add-wrapper "*" "*" nil 'org-mode)
  (wrap-region-add-wrapper "_" "_" nil 'org-mode)
  (wrap-region-add-wrapper "/" "/" nil 'org-mode)
  (wrap-region-add-wrapper "+" "+" nil 'org-mode)
  (wrap-region-add-wrapper "~" "~" nil 'org-mode)
  (wrap-region-add-wrapper "#" "#" nil 'org-mode)
  (wrap-region-add-wrapper "`" "`" nil 'markdown-mode))

;; 扩展块
(use-package expand-region
  :custom
  (expand-region-fast-keys-enabled nil)
  (expand-region-subword-enabled t)  
  :bind
  ("C-t" . er/expand-region))


;; 清除空格
(use-package ws-butler
  :hook ((text-mode . ws-butler-mode)
         (prog-mode . ws-butler-mode)))


(provide 'edit)
;;; edit.el ends here
