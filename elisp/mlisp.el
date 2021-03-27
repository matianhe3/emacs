;;; package --- Lisp 编辑
;;; Commentary:
;;; Code:


(use-package parinfer-rust-mode
 :hook emacs-lisp-mode
 :init (setq parinfer-rust-auto-download t))


(use-package elisp-slime-nav
  :bind
  ( :map emacs-lisp-mode-map
    ("M-." . elisp-slime-nav-find-elisp-thing-at-point)))

(use-package aggressive-indent
  :hook (emacs-lisp-mode . aggressive-indent-mode))


(provide 'mlisp)
;;; mlisp.el ends here
