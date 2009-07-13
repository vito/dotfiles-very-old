;;; Emacs configuration file

(setq dotfiles-dir "~/.emacs.d/")
(add-to-list 'load-path dotfiles-dir)
(add-to-list 'load-path (concat dotfiles-dir "vendor"))
(add-to-list 'load-path (concat dotfiles-dir "vendor/color-theme"))
(add-to-list 'load-path (concat dotfiles-dir "vendor/yasnippet.el"))
(add-to-list 'load-path (concat dotfiles-dir "slime"))

;; Misc. packages
(require 'cl)
(require 'saveplace)
(require 'ffap)
(require 'uniquify)
(require 'ansi-color)
(require 'recentf)
(require 'redo)
(require 'slime)
(require 'yasnippet)
(require 'unbound)
(require 'whitespace)
(require 'textile-mode)
(require 'color-theme)

;; My configs
(require 'defuns)
(require 'bindings)
(require 'misc)
(require 'eshell-conf)
(require 'lisp)

;; Slime
(setq inferior-lisp-program "/opt/local/bin/sbcl")
(slime-setup)

;; TRAMP
(setq tramp-default-method "ssh")

;; Backup and autosave cleanups
(defvar autosave-dir (concat "/tmp/emacs_autosaves/" (user-login-name) "/"))
(defvar backup-dir (concat "/tmp/emacs_backups/" (user-login-name) "/"))

(make-directory autosave-dir t)
(setq backup-directory-alist (list (cons "." backup-dir)))

(defun auto-save-file-name-p (filename)
  (string-match "^#.*#$" (file-name-nondirectory filename)))

(defun make-auto-save-file-name ()
  (concat autosave-dir
          (if buffer-file-name
              (concat "#" (file-name-nondirectory buffer-file-name) "#")
            (expand-file-name
             (concat "#%" (buffer-name) "#")))))


;; Snippets
(yas/initialize)
(yas/load-directory (concat dotfiles-dir "/vendor/yasnippet.el/snippets"))

;; Cosmetics
(set-face-font 'default "-apple-profont-medium-r-normal--9-90-72-72-m-90-iso10646-1")
(color-theme-initialize)
(color-theme-ir-black)

