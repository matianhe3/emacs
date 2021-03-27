;;; package --- 代码检查,格式化相关
;;; Commentary:
;;; Code:


;; 代码检查
(use-package flycheck
  :init (global-flycheck-mode))

;; 标准对齐
(use-package page-break-lines
  :custom
  (page-break-lines-char ?—)
  :custom-face
  (page-break-lines ((t (:weight extra-light))))
  :hook
  (dashboard-after-initialize . global-page-break-lines-mode))

;; 光标移动
(use-package mwim
  :bind
  ("C-a" . mwim-beginning-of-code-or-line)
  ("C-e" . mwim-end-of-code-or-line))


(provide 'formater)
;;; formater.el ends here
