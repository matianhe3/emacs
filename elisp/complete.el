;;; complete.el --- 自动完成
;;; Commentary:
;;; Code:


;; LSP mode
(use-package lsp-mode
  :commands lsp
  :custom ((lsp-headerline-breadcrumb-enable nil)
           (lsp-rust-analyzer-cargo-watch-command "clippy")
           (lsp-eldoc-render-all t)
           (lsp-idle-delay 0.6))
  :hook
  (lsp-mode . lsp-enable-which-key-integration))

;; Lsp UI
(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-peek-always-show t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-doc-enable nil)
  (lsp-ui-doc-show))

;; 彩虹美化
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package rainbow-mode
  :defer t
  :hook (org-mode
         emacs-lisp-mode
         web-mode
         typescript-mode
         js2-mode))

(use-package color-identifiers-mode
  :commands color-identifiers-mode)

;; 语言支持
(use-package yaml-mode
  :mode "\\.yaml\\'"
  :hook
  (yaml-mode . highlight-indent-guides-mode)
  (yaml-mode . display-line-numbers-mode))

(use-package gitignore-mode
  :mode "/\\.gitignore\\'")

(use-package csv-mode
  :mode "\\.csv\\'"
  :custom
  (csv-invisibility-default nil)
  :hook
  (csv-mode . csv-align-mode))



(use-package markdown-mode
  :mode "\\.md\\'"
  :custom (markdown-header-scaling t)
  :bind
  ( :map markdown-mode-map
    ("M-n" . markdown-next-visible-heading)
    ("M-p" . markdown-previous-visible-heading)
    ("C-M-j" . markdown-follow-thing-at-point)))


;; 差异对比
(use-package dimmer
  :commands dimmer-mode
  :custom
  (dimmer-fraction 0.5)
  :config
  (dimmer-configure-company-box)
  (dimmer-configure-which-key)
  (dimmer-configure-helm)
  (dimmer-configure-magit)
  (dimmer-configure-posframe))

;; 按键提示
(use-package which-key-posframe
  :custom
  (which-key-idle-secondary-delay 0)
  :custom-face
  (which-key-posframe-border ((t (:background "gray"))))
  :hook
  (dashboard-after-initialize . which-key-posframe-mode)
  (dashboard-after-initialize . which-key-mode))


;; 帮助增强
(use-package helpful
  :bind
  (([remap describe-function] . helpful-callable)
   ([remap describe-variable] . helpful-variable)
   ([remap describe-key] . helpful-key)
   :map emacs-lisp-mode-map
   ("C-c C-d" . helpful-at-point)))

;; 自动完成
(use-package company
  :custom
  (company-idle-delay 0)
  (company-minimum-prefix-length 1)
  :hook
  (dashboard-after-initialize . global-company-mode))

;; 代码片段
(use-package yasnippet
  :hook (prog-mode . yas-minor-mode)
  :bind ("C-c y" . 'company-yasnippet)
  :config (yas-reload-all))

(use-package yasnippet-snippets
  :after yasnippet)


(provide 'complete)
;;; complete.el ends here
