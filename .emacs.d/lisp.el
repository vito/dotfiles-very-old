;;; lisp.el

(add-to-list 'load-path (concat dotfiles-dir "slime"))
(add-to-list 'load-path (concat dotfiles-dir "slime/contrib"))

(require 'slime)
(require 'geiser)

;; (setq geiser-scheme-dir "/usr/local/share/geiser")

(eval-after-load "slime"
  '(progn
     (setq slime-lisp-implementations '((sbcl ("sbcl"))))
     (slime-setup '(slime-asdf
                    slime-autodoc
                    slime-editing-commands
                    slime-fancy-inspector
                    slime-fontifying-fu
                    slime-fuzzy
                    slime-indentation
                    slime-mdot-fu
                    slime-package-fu
                    slime-references
                    slime-repl
                    slime-sbcl-exts
                    slime-scratch
                    slime-xref-browser))
     (slime-autodoc-mode)
     (setq slime-complete-symbol*-fancy t
           slime-complete-sumbol-function 'slime-fuzzy-complete-symbol)))

(add-hook 'emacs-lisp-mode-hook 'eldoc-mode)
(add-hook 'emacs-lisp-mode-hook 'coding-hook)
(add-hook 'lisp-mode-hook 'coding-hook)

(add-hook 'emacs-lisp-mode-hook 'emacs-lisp-remove-elc-on-save)

(when (functionp 'paredit-mode)
  (add-hook 'emacs-lisp-mode-hook (lambda () (paredit-mode +1)))
  (add-hook 'lisp-mode-hook (lambda () (paredit-mode +1))))

(defun emacs-lisp-remove-elc-on-save ()
  "If you're saving an elisp file, likely the .elc is no longer valid."
  (make-local-variable 'after-save-hook)
  (add-hook 'after-save-hook
            (lambda ()
              (if (file-exists-p (concat buffer-file-name "c"))
                  (delete-file (concat buffer-file-name "c"))))))

(font-lock-add-keywords 'emacs-lisp-mode
                        '(("(\\|)" . 'paren-face)))

(font-lock-add-keywords 'scheme-mode
                        '(("(\\|)" . 'paren-face)))

(font-lock-add-keywords 'lisp-mode
                        '(("(\\|)" . 'paren-face)))

(font-lock-add-keywords 'lfe-mode
                        '(("(\\|)" . 'paren-face)))

(font-lock-add-keywords 'hen-mode
                        '(("(\\|)" . 'paren-face)))

(define-key lisp-mode-shared-map (kbd "C-c l") "lambda")
(define-key read-expression-map (kbd "TAB") 'lisp-complete-symbol)
(define-key lisp-mode-shared-map (kbd "RET") 'reindent-then-newline-and-indent)
(define-key lisp-mode-shared-map (kbd "C-\\") 'lisp-complete-symbol)
(define-key lisp-mode-shared-map (kbd "C-c v") 'eval-buffer)

(defface paren-face
  '((((class color) (background dark))
     (:foreground "grey20"))
    (((class color) (background light))
     (:foreground "grey55")))
  "Face used to dim parentheses."
  :group 'faces)

(autoload 'scheme-get-current-symbol-info "scheme-complete" nil t)
(add-hook 'scheme-mode-hook
  (lambda ()
    (make-local-variable 'eldoc-documentation-function)
    (setq eldoc-documentation-function 'scheme-get-current-symbol-info)
    (eldoc-mode)))

(provide 'lisp)
