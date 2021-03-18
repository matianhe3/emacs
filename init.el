;;; init.el --- 配置初始化
;;; Commentary:
;;; Code:
;;
;;插件源
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;;(add-to-list 'package-archives
;;             '("melpa-stable" . "https://stable.melpa.org/packages/"))
;;(add-to-list 'package-pinned-packages '(telega . "melpa-stable"))
(package-initialize)


;; 包管理
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(setq use-package-verbose t)
(setq use-package-always-ensure t)
(setq use-package-always-defer t)


;; 代理配置
(defun toggle-url-proxy ()
  "Toggle proxy for the url.el library."
  (interactive)
  (cond
   (url-proxy-services
    (message "Turn off URL proxy")
    (setq url-proxy-services nil))
   (t
    (message "Turn on URL proxy")
    (setq url-proxy-services
          '(("http" . "localhost:8889")
            ("https" . "localhost:8889")
            ("no_proxy" . "0.0.0.0"))))))
(toggle-url-proxy)


;; 配置文件快捷键
(defun open-init-file()
  "打开配置文件."
  (interactive)
  (find-file "~/.config/emacs/init.el"))
(global-set-key (kbd "<f1>") 'open-init-file)
(global-set-key (kbd "C-<f5>") 'load-file)

;; 关闭滚动条
(scroll-bar-mode -1)

;; 关闭工具栏
(tool-bar-mode -1)

;; 关闭菜单栏
(menu-bar-mode -1)

;; 开启行号
(global-display-line-numbers-mode +1)

;; 高亮当前行
(global-hl-line-mode 1)

;; 自动刷新被修改过的文件
(global-auto-revert-mode +1)

;; 选中文本后输入会覆盖
(delete-selection-mode +1)

;; 快捷确定
(fset 'yes-or-no-p 'y-or-n-p)

;; 关闭GUI功能
(setq use-file-dialog nil
      use-dialog-box nil
      inhibit-startup-screen t
      inhibit-startup-message t)

;; 关闭备份
(setq make-backup-files nil auto-save-default nil)

;; 关闭多编辑器同时编辑统一文件时锁文件操作
(setq create-lockfiles nil)

;; 随时重新加载发生修改过的文件
(setq load-prefer-newer t)


;; 关闭字体缓存gc
(setq inhibit-compacting-font-caches nil)

;; 关闭烦人的提示
(setq ring-bell-function 'ignore blink-cursor-mode nil)

;; 任何地方都使用UTF-8
(set-charset-priority 'unicode)
(setq locale-coding-system   'utf-8)
(set-terminal-coding-system  'utf-8)
(set-keyboard-coding-system  'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system        'utf-8)
(setq default-process-coding-system '(utf-8 . utf-8))

;; 更友好及平滑的滚动
(setq scroll-step 2
      scroll-margin 6
      hscroll-step 2
      hscroll-margin 2
      scroll-conservatively 101
      scroll-up-aggressively 0.01
      scroll-down-aggressively 0.01
      scroll-preserve-screen-position 'always)

;; 对齐创建的新行
(global-set-key (kbd "RET") 'newline-and-indent)
;; 取消对齐创建的新行
(global-set-key (kbd "S-<return>") 'comment-indent-new-line)

;; 让光标无法离开视线
(setq mouse-yank-at-point nil)

;; 最大单行字符数量
(setq-default fill-column 80)

;; 让'_'被视为单词的一部分
(add-hook 'after-change-major-mode-hook (lambda ()
                                          (modify-syntax-entry ?_ "w")))
;; "-" 同上)
(add-hook 'after-change-major-mode-hook (lambda ()
                                          (modify-syntax-entry ?- "w")))
;; 允许插入制表符
(setq-default indent-tabs-mode nil)

;; 制表符宽度
(setq-default tab-width 4)

;; 高亮对应的括号
(show-paren-mode 1)

;; 内存性能设置
(if (not (display-graphic-p))
    ;; increase gc memery
    (setq gc-cons-threshold (* 8192 8192))
  ;; increase LSP server cache
  (setq read-process-output-max (* 1024 1024 128)))


;; 跳转窗口
(use-package ace-window
  :init
  (progn
    (global-set-key [remap other-window] 'ace-window)
	;; 设置标记
    (custom-set-faces
     '(aw-leading-char-face
       ((t (:inherit ace-jump-face-foreground :height 3.0 :foreground "magenta")))))))


;; Theme And Font
(use-package zenburn-theme
  :init (load-theme 'zenburn t))
(set-face-attribute 'default nil
                    :family "Hack Nerd Font"
                    :height 150
                    :weight 'normal)
(set-cursor-color "red")


;; Mode Line
(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :config
  (progn (setq doom-modeline-height 25
               doom-modeline-bar-width 3
               doom-modeline-window-width-limit fill-column
               doom-modeline-project-detection 'project
               doom-modeline-buffer-file-name-style 'auto
               doom-modeline-icon (display-graphic-p)
               doom-modeline-major-mode-icon t
               doom-modeline-major-mode-color-icon t
               doom-modeline-buffer-state-icon t
               doom-modeline-buffer-modification-icon t
               doom-modeline-unicode-fallback nil
               doom-modeline-minor-modes nil
               doom-modeline-enable-word-count nil
               doom-modeline-continuous-word-count-modes '(markdown-mode gfm-mode org-mode)
               doom-modeline-buffer-encoding t
               doom-modeline-checker-simple-format t
               doom-modeline-number-limit 99
               doom-modeline-vcs-max-length 12
               doom-modeline-workspace-name t
               doom-modeline-vcs-max-length 12
               doom-modeline-lsp t
               doom-modeline-gnus t
               doom-modeline-persp-name t
               doom-modeline-env-version t
               doom-modeline-env-enable-python t
               doom-modeline-env-enable-go t
               doom-modeline-env-enable-rust t
               doom-modeline-env-python-executable "python3"
               doom-modeline-env-go-executable "go"
               doom-modeline-env-rust-executable "rustc"
               display-time-24hr-format 1))
  (display-battery-mode t)
  (display-time-mode t))


;; 启动界面
(use-package dashboard
  :init (dashboard-setup-startup-hook)
  :config (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*"))
                dashboard-banner-logo-title "MTH's Emacs ."
                dashboard-set-heading-icons t
                dashboard-set-file-icons t
                dashboard-set-navigator t
                dashboard-items '((recents . 10)
                                  (projects . 5)
                                  (bookmarks . 10))))
         

;; Emacs Use
(use-package helpful
  :bind
  (("C-h f" . helpful-callable)
   ("C-h v" . helpful-variable)
   ("C-h k" . helpful-key)))
(use-package elisp-demos
  :config
  (advice-add 'helpful-update :after #'elisp-demos-advice-helpful-update))
(use-package symbol-overlay
  :ensure t
  :hook (emacs-lisp-mode . symbol-overlay-mode))


;; 删除空白符
(use-package hungry-delete
  :init (global-hungry-delete-mode))


;; Exec Shell
(use-package exec-path-from-shell)
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))


;; 终端
(use-package vterm
  :bind (("C-<f3>" . 'vterm)))


;; Telegram
(use-package telega
  :load-path "~/.config/emacs/telega.el"
  :commands (telega)
  :init (setq telega-proxies
              '((:server "localhost"
                         :port "1089"
                         :enable t
                         :type (:@type "proxyTypeSocks5")))))


;; Rainbow
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))


;; Undo Tree
(use-package undo-tree
  :config
  (global-undo-tree-mode)
  (setq undo-tree-visualizer-timestamps t))


;; Display Keybind
(use-package which-key
  :config
  (which-key-mode))


;; Recent File
(use-package recentf
  :config
  (setq recentf-max-saved-items 50
        recentf-max-menu-items 15)
  (progn (recentf-mode))
  (global-set-key (kbd "C-x C-r") 'recentf-open-files))


;; Auto Pair Bracket
(use-package autopair
  :hook (prog-mode . autopair-global-mode))


;; Git
(use-package magit)


;; Icons
(use-package all-the-icons
  :after memoize
  :load-path "site-lisp/all-the-icons")


;; Treemacs
(use-package treemacs
  :config
  (progn
    (setq treemacs-collapse-dirs                 (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay      0.5
          treemacs-directory-name-transformer    #'identity
          treemacs-display-in-side-window        t
          treemacs-eldoc-display                 t
          treemacs-file-event-delay              5000
          treemacs-file-extension-regex          treemacs-last-period-regex-value
          treemacs-file-follow-delay             0.2
          treemacs-file-name-transformer         #'identity
          treemacs-follow-after-init             t
          treemacs-git-command-pipe              ""
          treemacs-goto-tag-strategy             'refetch-index
          treemacs-indentation                   2
          treemacs-indentation-string            " "
          treemacs-is-never-other-window         nil
          treemacs-max-git-entries               5000
          treemacs-missing-project-action        'ask
          treemacs-move-forward-on-expand        nil
          treemacs-no-png-images                 nil
          treemacs-no-delete-other-windows       t
          treemacs-project-follow-cleanup        nil
          treemacs-persist-file                  (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                      'left
          treemacs-read-string-input             'from-child-frame
          treemacs-recenter-distance             0.1
          treemacs-recenter-after-file-follow    nil
          treemacs-recenter-after-tag-follow     nil
          treemacs-recenter-after-project-jump   'always
          treemacs-recenter-after-project-expand 'on-distance
          treemacs-show-cursor                   nil
          treemacs-show-hidden-files             t
          treemacs-silent-filewatch              nil
          treemacs-silent-refresh                nil
          treemacs-sorting                       'alphabetic-asc
          treemacs-space-between-root-nodes      t
          treemacs-tag-follow-cleanup            t
          treemacs-tag-follow-delay              1.5
          treemacs-user-mode-line-format         nil
          treemacs-user-header-line-format       nil
          treemacs-width                         35
          treemacs-workspace-switch-cleanup      nil))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("<f2>"      . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after (treemacs evil))

(use-package treemacs-projectile
  :after (treemacs projectile))

(use-package treemacs-icons-dired
  :after (treemacs dired)
  :config (treemacs-icons-dired-mode))

(use-package treemacs-magit
  :after (treemacs magit))

(use-package treemacs-persp
  :after (treemacs persp-mode))


;; ivy
(use-package counsel)
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-x l") 'counsel-locate)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)


;; 代码检查
(use-package flycheck
  :init (global-flycheck-mode))


;; 代码片段
(use-package yasnippet
  :hook ('prog-mode-hook #'yas-minor-mode))
(use-package yasnippet-snippets)


;; LSP mode
(use-package lsp-mode
  :hook ((go-mode . lsp-deferred)
         (typescript-mode . lsp-deferred)
         (rustic-mode . lsp-deferred))
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  :custom
  (lsp-rust-analyzer-cargo-watch-command "clippy"))

(use-package lsp-ui
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-doc-position 'at-point)
  :custom
  (lsp-ui-peek-always-show t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-mode t))

(use-package lsp-treemacs
  :commands lsp-treemacs-errors-list
  :config
  (progn(lsp-treemacs-sync-mode 1)))

(use-package lsp-ivy
  :commands lsp-ivy-workspace-symbol)


;; Julia
(use-package julia-mode)
(use-package lsp-julia
  :hook (julia-mode . (lambda ()
                        (require 'lsp-julia)
                        (lsp-deferred))))


;; AutoCompany
(use-package company
  :init
  (global-company-mode t))


;; Rust
(use-package rustic
  :config
  (setq rustic-format-on-save t))


;; Python
(use-package lsp-pyright
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp-deferred))))


;; GoLang
(defun lsp-go-install-save-hooks ()
  "保存代码自动格式化."
  (add-hook 'before-save-hook 'lsp-format-buffer t t)
  (add-hook 'before-save-hook 'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)


;; TypeScript
(use-package tide
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save)))


;; Yaml Dockerfile Json
(use-package yaml-mode)
(use-package dockerfile-mode)
(use-package json-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(zenburn-theme yasnippet-snippets yaml-mode which-key use-package undo-tree treemacs-projectile treemacs-persp treemacs-magit treemacs-icons-dired treemacs-evil tide symbol-overlay rustic rainbow-delimiters lsp-ui lsp-treemacs lsp-pyright json-mode hungry-delete helpful go-mode exec-path-from-shell elisp-demos doom-modeline dockerfile-mode dashboard counsel company autopair alert))
 '(safe-local-variable-values '((encoding . utf-8))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 3.0 :foreground "magenta")))))
(provide 'init)
;;; init.el ends here
(put 'narrow-to-region 'disabled nil)
