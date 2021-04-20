;;; mgolang.el --- golang 相关
;;; Commentary:
;;; Code:


(use-package go-mode
  :mode "\\.go\\'"
  :custom
  (gofmt-command "goimports")
  
  :hook
  (go-mode . flycheck-mode)
  (go-mode . lsp-deferred))


(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

(provide 'mgolang)

;;; mgolang.el ends here



