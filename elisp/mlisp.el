;;; mlisp.el --- Lisp 编辑
;;; Commentary:
;;; Code:


(use-package parinfer-rust-mode
  :hook emacs-lisp-mode
  :init (setq parinfer-rust-auto-download t))


(use-package aggressive-indent
  :hook (emacs-lisp-mode . aggressive-indent-mode))

(add-hook 'emacs-lisp-mode-hook #'flycheck-mode)


(provide 'mlisp)
;;; mlisp.el ends here
