;;; package --- js html json 相关
;;; Commentary:
;;; Code:


(use-package json-mode
  :mode ("\\.json\\'" . json-mode))
(use-package json-navigator
  :commands json-navigator-navigate-region)

(use-package company-web
  :after web-mode
  :config
  (add-to-list 'company-backends '(company-web-html :with company-yasnippet)))

(use-package prettier-js
  :hook
  (web-mode . prettier-js-mode)
  (css-mode . prettier-js-mode)
  (json-mode . prettier-js-mode)
  (js2-mode . prettier-js-mode))

(use-package auto-rename-tag
  :hook
  (web-mode . auto-rename-tag-mode))

(use-package js2-mode
  :mode "\\.js\\'"
  :custom
  (js-indent-level 2)
  :hook
  (js2-mode . flycheck-mode)
  ;;(js2-mode . (lambda () (require 'tree-sitter-langs) (tree-sitter-hl-mode)))
  (js2-mode . lsp-deferred))

(provide 'mweb.el)
;;; mweb.el ends here
