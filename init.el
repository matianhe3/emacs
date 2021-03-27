;;; init.el --- 配置初始化
;;; Commentary:
;;; Code:
;;


;; 垃圾回收, 提高性能
(setq gc-cons-threshold (* 50 1000 1000))

;; 启动用时
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "*** Emacs loaded in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))

;; native comp特性
(setq comp-async-report-warnings-errors nil)


;; 代理配置
(setq url-proxy-services nil)
(defun toggle-proxy ()
  "Toggle proxy for the url.el library."
  (interactive)
  (cond
   (url-proxy-services
    (message "Turn off URL proxy")
    (setq url-proxy-services nil))
   (t
    (message "Turn on URL proxy")
    (setq url-proxy-services
          '(("http" . "http://localhost:7890")
            ("https" . "http://localhost:7890")
            ("no_proxy" . "0.0.0.0"))))))
(toggle-proxy)


;; 包管理工具
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)


;; 收集临时文件
(setq user-emacs-directory (expand-file-name "~/.cache/emacs/")
      url-history-file (expand-file-name "url/history" user-emacs-directory))
(use-package no-littering)
;; 个性化配置单独文件
(setq custom-file
      (if (boundp 'server-socket-dir)
          (expand-file-name "custom.el" server-socket-dir)
        (expand-file-name (format "emacs-custom-%s.el" (user-uid)) temporary-file-directory)))
(load custom-file t)

(push "~/.config/emacs/elisp" load-path)

;; 任何地方都使用UTF-8
(set-default-coding-systems 'utf-8)

;; 服务器式启动
(server-start)

;; ESC退出
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)


;; 执行终端命令
(straight-use-package 'exec-path-from-shell)
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; 配置文件快捷键
(defun open-init-file()
  "打开配置文件."
  (interactive)
  (dired "~/.config/emacs/elisp"))
(global-set-key (kbd "<f1>") 'open-init-file)
;; macOS 不支持 ls目录处理
(when (string= system-type "darwin")
  (setq dired-use-ls-dired nil))




;; 更友好及平滑的滚动
(setq scroll-step 5
      scroll-margin 10
      hscroll-step 5
      hscroll-margin 5
      scroll-conservatively 101
      scroll-up-aggressively 0.01
      use-dialog-box nil
      mouse-wheel-follow-mouse 't
      mouse-wheel-progressive-speed nil
      scroll-down-aggressively 0.01
      scroll-preserve-screen-position 'always
      large-file-warning-threshold nil
      vc-follow-symlinks t
      ad-redefinition-action 'accept)

;; 基础修改
(setq-default
 ring-bell-function 'ignore            ; prevent beep sound.
 inhibit-startup-screen t              ; TODO: maybe better on early-init or performance?
 initial-major-mode 'fundamental-mode  ; TODO: maybe better on early-init or performance?
 initial-scratch-message nil           ; TODO: maybe better on early-init?
 create-lockfiles nil                  ; .#locked-file-name
 confirm-kill-processes nil            ; exit emacs without asking to kill processes
 backup-by-copying nil                 ; prevent linked files
 make-backup-files nil
 visible-bell t
 require-final-newline t               ; always end files with newline
 delete-old-versions t                 ; don't ask to delete old backup files
 revert-without-query '(".*")          ; `revert-buffer' without confirmation
 uniquify-buffer-name-style 'forward
 mode-line-format nil
 fill-column 80
 sentence-end-double-space nil
 indent-tabs-mode nil
 tab-width 4
 mouse-yank-at-point nil)
(defalias 'yes-or-no-p 'y-or-n-p)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(delete-selection-mode)
(set-fringe-mode 10)
(show-paren-mode 1)
(column-number-mode)
(display-line-numbers-mode 1)


;; 让'_'被视为单词的一部分
(add-hook 'after-change-major-mode-hook (lambda ()
                                          (modify-syntax-entry ?_ "w")))
;; "-" 同上)
(add-hook 'after-change-major-mode-hook (lambda ()
                                          (modify-syntax-entry ?- "w")))




;; 文件处理
(defvar default-file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq file-name-handler-alist default-file-name-handler-alist)) 100)


;; 主题字体
(use-package zenburn-theme
  :init (load-theme 'zenburn t))
(set-face-attribute 'default nil
                    :font "Fira Mono"
                    :height 170)
(use-package unicode-fonts
  :config
  (unicode-fonts-setup))
(use-package emojify
  :hook (erc-mode . emojify-mode)
  :commands emojify-mode)



;; 加载模块
(add-to-list 'load-path "~/.config/emacs/elisp/")
(require 'complete)
(require 'formater)
(require 'undo)
(require 'mlisp)
(require 'modeline)
(require 'search)
(require 'dashboard)
(require 'mwindow)
(require 'project)
(require 'edit)
(require 'coding)
(require 'mpython)
(require 'mgolang)
(require 'file)
(require 'terminal)
(require 'mrust)


;;; init.el ends here
