;;; mweb.el --- js html json 相关
;;; Commentary:
;;; Code:


(use-package json-mode
  :mode ("\\.json\\'" . json-mode))

(use-package json-navigator
  :commands json-navigator-navigate-region)

(use-package web-mode
  :mode "(\\.\\(html?\\|ejs\\|tsx\\|jsx\\)\\'"
  :config
  (setq-default web-mode-code-indent-offset 2)
  (setq-default web-mode-markup-indent-offset 2)
  (setq-default web-mode-attribute-indent-offset 2))


(use-package prettier-js
  :hook
  (web-mode . prettier-js-mode)
  (css-mode . prettier-js-mode)
  (json-mode . prettier-js-mode)
  (js2-mode . prettier-js-mode))

(use-package auto-rename-tag
  :hook
  (web-mode . auto-rename-tag-mode))

(use-package apheleia
  :config
  (apheleia-global-mode +1))


(use-package typescript-mode
  :mode "\\.\\(ts\\|tsx\\)\\'"
  :hook (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 2))

(provide 'mweb)
;;; mweb.el ends here
