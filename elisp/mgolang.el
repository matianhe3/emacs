;;; package --- golang 相关
;;; Commentary:
;;; Code:


(use-package go-mode
  ;; install go & go-tools, for arch based linux:
  ;; sudo pacman -S go go-tools
  :mode "\\.go\\'"
  :init
  (defface golang-blue
    '((((background dark)) :foreground "#69D7E4")
      (((background light)) :foreground "#69D7E4"))
    "Face for golang icon")
  (add-to-list 'all-the-icons-icon-alist
               '("\\.go$" all-the-icons-fileicon "go" :height 1 :face golang-blue))
  
  :custom
  (gofmt-command "goimports")
  
  :hook
  (go-mode . flycheck-mode)
  (go-mode . lsp-deferred)
  (go-mode . lsp-go-install-save-hooks)
  
  :config
  (defun lsp-go-install-save-hooks ()
    (add-hook 'before-save-hook #'lsp-format-buffer t t)
    (add-hook 'before-save-hook #'lsp-organize-imports t t)))


(provide 'mgolang)

;;; mgolang.el ends here



