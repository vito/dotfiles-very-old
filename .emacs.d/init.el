;;; Emacs Init

(setq dotfiles-dir "~/.emacs.d/")
(add-to-list 'load-path "/usr/share/emacs/site-lisp")
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp")
(add-to-list 'load-path dotfiles-dir)
(add-to-list 'load-path (concat dotfiles-dir "vendor"))

(setq exec-path (append exec-path '("/usr/local/bin" "/opt/local/bin" "~/.bin" "/Applications/PLT Scheme/bin")))

;; Packages
(require 'cl)
(require 'ffap)
(require 'uniquify)
(require 'recentf)
(require 'redo)
(require 'unbound)
(require 'magit)
(require 'color-theme)
(require 'protobuf-mode)
(require 'go-mode)
(require 'markdown-mode)

;; Configs
(require 'defuns)
(require 'bindings)
(require 'environ)
(require 'eshell-conf)
(require 'lisp)
(require 'haskell)
(require 'php)
(require 'erlang)
