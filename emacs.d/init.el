
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'package)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (## org-plus-contrib))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(define-skeleton insert-org-entry
                 "Prompt for task, estimate and category"
                 nil
                 '(setq task  (skeleton-read "Task: "))
                 '(setq estimate  (skeleton-read "Estimate: "))
                 '(setq category (skeleton-read "Category: "))
                 '(setq timestamp (format-time-string "%s"))
                 "** " task \n
                 ":PROPERTIES:" \n
                 ":ESTIMATED: " estimate \n
                 ":ACTUAL:" \n
                 ":OWNER: shaks" \n
                 ":ID: " category "." timestamp \n
                 ":TASKID: " category "." timestamp \n
                 ":END:")

(defun org-update-actuals ()
  (interactive)
  (org-entry-put (point) "ACTUAL"
                 (format "%0.2f" (/ (org-clock-sum-current-item) 60.0))))

(global-set-key (kbd "C-c s c") 'org-update-actuals)
