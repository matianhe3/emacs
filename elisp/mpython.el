;;; package --- python模块
;;; Commentary:
;;; Code:


(use-package lsp-pyright
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp))))

(provide 'mpython)

;;; mpython.el ends here
