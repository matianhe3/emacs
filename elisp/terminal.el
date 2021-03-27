;;; package --- 终端
;;; Commentary:
;;; Code:


(use-package vterm
  :custom
  (vterm-max-scrollback 100000))

(use-package shell-pop
  :custom
  (shell-pop-shell-type '("vterm" "*vterm*" (lambda () (vterm))))
  (shell-pop-full-span t)
  :bind*
  (("M-t" . shell-pop)))


(provide 'terminal)

;;; terminal.el ends here
