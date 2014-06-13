(setq genki-org-current-task "NOT CLOCKING IN...")
(defun genki/tmux-set-status-right ()
  (call-process "tmux"
                nil 0 nil
                "set" "status-right" genki-org-current-task))

(defun genki/org-clock-current-task-to-tmux-statusline ()
  (if (org-clocking-p)
      (if org-clock-current-task
          (setq genki-org-current-task org-clock-current-task)
          (setq genki-org-current-task "CAPTURING"))
        (setq genki-org-current-task "NOT CLOCKING IN..."))
      (genki/tmux-set-status-right))

(defun genki/org-capture-buffer-setup ()
  ;; things always done
  (evil-insert 1)
  ;; things done according to capture template
  (when (stringp read-char-exclusive-last-input)
    (pcase read-char-exclusive-last-input
      ("7" (genki/org-capture-750-words-setup)))))

(defun genki/org-capture-750-words-setup ()
  (wc-mode)
  (wc-set-word-goal 10))
