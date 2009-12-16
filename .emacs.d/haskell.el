;;; haskell.el

(load "~/.emacs.d/vendor/haskell-mode/haskell-site-file")

(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'eldoc-mode)

(provide 'haskell)
