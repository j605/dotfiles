;;; setup-mail.el --- Setup mu4e
;; This was an awesome resource : http://d.hatena.ne.jp/kenbeese/20121129/1354442823

(require 'mu4e)

;; default
;; (setq mu4e-maildir "~/Maildir")

(setq mu4e-drafts-folder "/Gmail/Drafts")
(setq mu4e-sent-folder   "/Gmail/Sent Mail")
(setq mu4e-trash-folder  "/Gmail/Bin")
(setq mu4e-attachment-dir  "~/Downloads") ;; attachments are saved here

;; don't save message to Sent Messages, Gmail/IMAP takes care of this
(setq mu4e-sent-messages-behavior 'delete)

;; setup some handy shortcuts
;; you can quickly switch to your Inbox -- press ``ji''
;; then, when you want archive some messages, move them to
;; the 'All Mail' folder by pressing ``ma''.

(setq mu4e-maildir-shortcuts
      '(("/INBOX"               . ?i)))

;; allow for updating mail using 'U' in the main view:
(setq mu4e-get-mail-command "zsh -i -c offlineimap") ;; I don't know why, but it only works under interactive zsh
(setq mu4e-update-interval 300) ;; update every 5 minutes

;; something about ourselves
(setq
  user-mail-address (getenv "MY_EMAIL")
  user-full-name (getenv "MY_NAME")
  message-signature
  (concat
    "Genki Sugimoto\n"
    "Waseda University\n"
    "Washizaki Laboratory\n"
    "\n"
    "http://genkisugimoto.com"))
(setq mu4e-compose-signature message-signature)

;; sending mail
;; make sure the gnutls command line utils are installed
(require 'smtpmail)

(setq message-send-mail-function 'smtpmail-send-it
      starttls-use-gnutls t
      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
      smtpmail-auth-credentials
      '(("smtp.gmail.com" 587 "cfhoyuk.reccos.nelg@gmail.com" nil))
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587)

;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)

;;; message view action
;; http://www.emacswiki.org/emacs/mu4e
(defun mu4e-msgv-action-view-in-browser (msg)
  "View the body of the message in a web browser."
  (interactive)
  (let ((html (mu4e-msg-field (mu4e-message-at-point t) :body-html))
        (tmpfile (format "%s/%d.html" temporary-file-directory (random))))
    (unless html (error "No html part for this message"))
    (with-temp-file tmpfile
    (insert
        "<html>"
        "<head><meta http-equiv=\"content-type\""
        "content=\"text/html;charset=UTF-8\">"
       html))
    (browse-url (concat "file://" tmpfile))))
(add-to-list 'mu4e-view-actions
  '("View in browser" . mu4e-msgv-action-view-in-browser) t)

;; For encrypting password
(require 'epa-file)
(epa-file-enable)
(setq auth-sources '("~/.authinfo.gpg" "~/.authinfo" "~/.netrc"))

(require 'netrc)
(defun offlineimap-get-password (host port)
  (let* ((netrc (netrc-parse (expand-file-name "~/.authinfo.gpg")))
         (hostentry (netrc-machine netrc host port port)))
    (when hostentry (netrc-get hostentry "password"))))

;; for multiple accounts
;; http://www.djcbsoftware.nl/code/mu/mu4e/Multiple-accounts.html
(defvar my-mu4e-account-alist
  '(("Gmail"
     (mu4e-drafts-folder "/Gmail/Drafts")
     (mu4e-sent-folder "/Gmail/Sent Mail")
     (mu4e-trash-folder  "/Gmail/Bin")
     (user-mail-address "cfhoyuk.reccos.nelg@gmail.com"))
    ("Waseda"
     (mu4e-drafts-folder "/Waseda/Drafts")
     (mu4e-sent-folder "/Waseda/Sent Mail")
     (mu4e-trash-folder  "/Waseda/Bin")
     (user-mail-address "genki-sugimoto@asagi.waseda.jp"))))

(defun my-mu4e-set-account ()
  "Set the account for composing a message."
  (let* ((account
           (completing-read (format "Compose with account: (%s) "
                                    (mapconcat #'(lambda (var) (car var)) my-mu4e-account-alist "/"))
                            (mapcar #'(lambda (var) (car var)) my-mu4e-account-alist)
                            nil t nil nil (caar my-mu4e-account-alist)))
         (account-vars (cdr (assoc account my-mu4e-account-alist))))
    (if account-vars
      (mapc #'(lambda (var)
                (set (car var) (cadr var)))
            account-vars)
      (error "No email account found"))))

(add-hook 'mu4e-compose-pre-hook 'my-mu4e-set-account)

(provide 'setup-mail)
;;; setup-mail.el ends here
