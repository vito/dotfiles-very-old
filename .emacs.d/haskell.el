;;; haskell.el

(require 'haskell-indentation)

(load "/usr/share/emacs/site-lisp/haskell-mode/haskell-site-file")

(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'haskell-indentation-mode)

(provide 'haskell)