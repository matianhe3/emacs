;;; package --- 编程相关
;;; Commentary:
;;; Code:


;; LSP mode
(use-package lsp-mode
  :commands lsp
  :custom
  (lsp-auto-guess-root t)
  (lsp-keymap-prefix "M-m l")
  (lsp-modeline-diagnostics-enable nil)
  (lsp-keep-workspace-alive nil)
  (lsp-auto-execute-action nil)
  (lsp-before-save-edits nil)
  (lsp-eldoc-enable-hover nil)
  (lsp-diagnostic-package :none)
  (lsp-completion-provider :none)
  (lsp-file-watch-threshold 1500)
  (lsp-enable-links)
  :custom-face
  (lsp-face-highlight-read ((t (:underline t :background nil :foreground nil))))
  (lsp-face-highlight-write ((t (:underline t :background nil :foreground nil))))
  (lsp-face-highlight-textual ((t (:underline t :background nil :foreground nil))))
  :hook
  (lsp-mode . lsp-enable-which-key-integration))



;; LSP UI
(use-package lsp-ui
  :after lsp-mode
  :custom
  (lsp-ui-doc-show-with-cursor nil)
  (lsp-ui-doc-position 'at-point)
  (lsp-ui-sideline-delay 0.5)
  (lsp-ui-peek-fontify 'always)
  (lsp-ui-peek-always-show t)
  :custom-face
  (lsp-ui-peek-highlight ((t (:inherit nil :background nil :foreground nil :weight semi-bold :box (:line-width -1)))))
  :bind
  ( :map lsp-ui-mode-map
    ([remap xref-find-references] . lsp-ui-peek-find-references)
    ("C-M-l" . lsp-ui-peek-find-definitions)
    ("C-c C-d" . lsp-ui-doc-show))
  :config
  ;;;; LSP UI posframe ;;;;
  (defun lsp-ui-peek--peek-display (src1 src2)
    (-let* ((win-width (frame-width))
            (lsp-ui-peek-list-width (/ (frame-width) 2))
            (string (-some--> (-zip-fill "" src1 src2)
                      (--map (lsp-ui-peek--adjust win-width it) it)
                      (-map-indexed 'lsp-ui-peek--make-line it)
                      (-concat it (lsp-ui-peek--make-footer)))))
      
      (setq lsp-ui-peek--buffer (get-buffer-create " *lsp-peek--buffer*"))
      (posframe-show lsp-ui-peek--buffer
                     :string (mapconcat 'identity string "")
                     :min-width (frame-width)
                     :poshandler 'posframe-poshandler-frame-center)))

  (defun lsp-ui-peek--peek-destroy ()
    (when (bufferp lsp-ui-peek--buffer)
      (posframe-delete lsp-ui-peek--buffer))
    (setq lsp-ui-peek--buffer nil
          lsp-ui-peek--last-xref nil)
    (set-window-start (get-buffer-window) lsp-ui-peek--win-start))

  (advice-add 'lsp-ui-peek--peek-new :override 'lsp-ui-peek--peek-display)
  (advice-add 'lsp-ui-peek--peek-hide :override 'lsp-ui-peek--peek-destroy))

;; 彩虹美化
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

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

(provide 'coding)

;;; coding.el ends here
