;;; package --- 自动完成
;;; Commentary:
;;; Code:


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
  (company-tooltip-align-annotations t)
  (company-dabbrev-downcase nil)
  (company-dabbrev-other-buffers t)
  :bind
  ( :map company-active-map
    ("RET" . nil)
    ([return] . nil)
    ("TAB" . company-complete-selection)
    ("<tab>" . company-complete-selection)
    ("C-s" . company-complete-selection)
    ("C-n" . company-select-next)
    ("C-p" . company-select-previous))
  :hook
  (dashboard-after-initialize . global-company-mode)
  :config
  (add-to-list 'company-begin-commands 'backward-delete-char-untabify)

  ;; Show YASnippet snippets in company
  (defun fk/company-backend-with-yas (backend)
    "Add ':with company-yasnippet' to the given company backend."
    (if (and (listp backend) (member 'company-yasnippet backend))
        backend
      (append (if (consp backend)
                  backend
                (list backend))
              '(:with company-yasnippet))))

  (defun fk/company-smart-snippets (fn command &optional arg &rest _)
    "Do not show yasnippet candidates after dot."
    (unless (when (and (equal command 'prefix) (> (point) 0))
              (let* ((prefix (company-grab-symbol))
                     (point-before-prefix (if (> (- (point) (length prefix) 1) 0)
                                              (- (point) (length prefix) 1)
                                            1))
                     (char (buffer-substring-no-properties point-before-prefix (1+ point-before-prefix))))
                (string= char ".")))
      (funcall fn command arg)))

  ;; TODO: maybe show snippets at first?
  (defun fk/company-enable-snippets ()
    "Enable snippet suggestions in company by adding ':with
company-yasnippet' to all company backends."
    (interactive)
    (setq company-backends (mapcar 'fk/company-backend-with-yas company-backends))
    (advice-add 'company-yasnippet :around 'fk/company-smart-snippets))
  (fk/company-enable-snippets))


;; 美化自动完成框
(use-package company-box
  :hook (company-mode . company-box-mode))

;; 排序
(use-package prescient
  :hook (dashboard-after-initialize . prescient-persist-mode))

(use-package company-prescient
  :after company
  :config (company-prescient-mode))


;; 代码片段
(use-package yasnippet
  :custom
  (yas-indent-line nil)
  (yas-inhibit-overlay-modification-protection t)
  :custom-face
  (yas-field-highlight-face ((t (:inherit region))))
  :bind*
  (("C-j" . yas-expand)
   :map yas-minor-mode-map
   ("TAB" . nil)
   ("<tab>" . nil)
   :map yas-keymap
   ("TAB" . (lambda () (interactive) (company-abort) (yas-next-field)))
   ("<tab>" . (lambda () (interactive) (company-abort) (yas-next-field))))
  :hook
  (dashboard-after-initialize . yas-global-mode)
  (snippet-mode . (lambda () (setq-local require-final-newline nil))))

(use-package yasnippet-snippets
  :after yasnippet)


(provide 'complete)
;;; complete.el ends here
