;;; dashboard.el --- 启动显示
;;; Commentary:
;;; Code:

;; 仪表盘
(use-package dashboard
  :custom
  (dashboard-banner-logo-title "MTH's EMACS.")
  (dashboard-set-heading-icons t)
  (dashboard-set-file-icons t)
  (dashboard-center-content t)
  (dashboard-agenda-time-string-format "%d/%m/%Y %A %H:%M")
  (dashboard-item-shortcuts '((recents . "r")
                              (bookmarks . "b")
                              (projects . "p")
                              (agenda . "a")))
  (dashboard-items '((recents  . 10)
                     (projects . 5)))
  (dashboard-set-navigator t)
  :config
  (dashboard-setup-startup-hook))


(provide 'dashboard)
;;; dashboard ends here
