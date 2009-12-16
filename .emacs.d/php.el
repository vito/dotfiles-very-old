;;; php.el

(require 'php-mode)

(add-hook 'php-mode-hook '(lambda () (c-set-offset 'topmost-intro 4)))
(add-hook 'php-mode-hook '(lambda () (c-set-offset 'cpp-macro -4)))

(provide 'php)
