;;; mrust.el --- Rust 配置
;;; Commentary:
;;; Code:


(use-package rustic
  :config
  (setq rustic-format-on-save t))
(remove-hook 'rustic-mode-hook 'flycheck-mode)


(provide 'mrust)
;;; mrust.el ends here
