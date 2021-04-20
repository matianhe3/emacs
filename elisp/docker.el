;;; docker.el --- docker配置
;;; Commentary:
;;; Code:


(use-package docker
  :commands docker)

(use-package docker-tramp
  :defer t
  :after docker)

(provide 'docker)
;;; docker.el ends here
