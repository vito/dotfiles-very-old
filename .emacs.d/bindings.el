;;; bindings.el


;; Common functions get F1-F4
(global-set-key [f1] 'eshell)
(global-set-key [f2] 'split-window-horizontally)
(global-set-key [f3] 'split-window-vertically)
(global-set-key [f4] 'delete-window)

;; Navigation
(global-set-key [(meta up)]           'beginning-of-buffer)
(global-set-key [(meta down)]         'end-of-buffer)
(global-set-key [(meta shift right)]  'ido-switch-buffer)
(global-set-key [(meta shift up)]     'recentf-ido-find-file)
(global-set-key [(meta shift down)]   'ido-find-file)
(global-set-key [(meta shift left)]   'magit-status)

;; Resizing
(global-set-key (kbd "S-C-<left>")   'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>")  'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>")   'shrink-window)
(global-set-key (kbd "S-C-<up>")     'enlarge-window)

;; Editing
(global-set-key (kbd "C--")     'redo)
(global-set-key (kbd "C-x \\")  'align-regexp)
(global-set-key (kbd "C-c n")   'cleanup-buffer)
(global-set-key (kbd "RET")     'newline-and-indent)
(global-set-key (kbd "C-/") 'comment-or-uncomment-region-or-line)
(global-set-key (kbd "C-S-r")   [?\C-a ?\C- ])

;; Searching
(global-set-key (kbd "C-s")      'isearch-forward-regexp)
(global-set-key (kbd "C-r")      'isearch-backward-regexp)
(global-set-key (kbd "C-M-s")    'isearch-forward)
(global-set-key (kbd "C-M-r")    'isearch-backward)
(global-set-key (kbd "C-x C-i")  'ido-imenu)

;; Finding files
(global-set-key (kbd "C-x M-f")    'ido-find-file-other-window)
(global-set-key (kbd "C-x C-M-f")  'find-file-in-project)
(global-set-key (kbd "C-x f")      'recentf-ido-find-file)
(global-set-key (kbd "C-x C-p")    'find-file-at-point)
(global-set-key (kbd "C-c y")      'bury-buffer)
(global-set-key (kbd "C-c r")      'revert-buffer)
(global-set-key (kbd "M-`")        'file-cache-minibuffer-complete)
(global-set-key (kbd "C-x C-b")    'ibuffer)

;; Proper delete functionality
(global-set-key [kp-delete] 'delete-char)

;; Window switching. (Shift + Directional arrow)
(windmove-default-keybindings)

;; Anthy
(global-set-key (kbd "C-x C-a") 'anthy-mode)

;; Shells
                                        ; Eshell
(global-set-key (kbd "C-x m") 'eshell)
(global-set-key (kbd "C-x M") (lambda () (interactive) (eshell t)))
                                        ; ansi-term
(global-set-key (kbd "C-x C-m") 'ansi-term)

;; Misc
(global-set-key (kbd "C-h a")  'apropos)
(global-set-key (kbd "C-c e")  'eval-and-replace)
(global-set-key (kbd "C-x g")  'magit-status)
(global-set-key (kbd "M-n")    'toggle-fullscreen)

;; Activate occur easily inside isearch
(define-key isearch-mode-map (kbd "C-o")
  (lambda () (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp isearch-string (regexp-quote isearch-string))))))

;; sexp+whitespace deletion quickies
(defun clear-whitespace ()
  (interactive)
  (set-mark-command nil)
  (search-backward-regexp "[^[:space:]
]")
  (forward-char)
  (kill-region (point) (mark)))

(global-set-key (kbd "s-<backspace>") 'clear-whitespace)

(global-set-key (kbd "C-M-<backspace>") (lambda ()
                                          (interactive)
                                          (backward-kill-sexp)
                                          (clear-whitespace)))

(provide 'bindings)
