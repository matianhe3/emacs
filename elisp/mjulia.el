;;; mjulia.el --- Julia相关
;;; Commentary:
;;; Code:


(use-package lsp-julia
  :config
  (setq lsp-julia-package-dir nil
        lsp-julia-default-environment "~/.config/julia/environments/v1.6"
        lsp-julia-default-depot "~/.config/julia/")
  :hook ((julia-mode . (lambda () (require 'lsp-julia)))
         (julia-mode . lsp-deferred)))



(provide 'mjulia)
;;; mjulia.el ends here
