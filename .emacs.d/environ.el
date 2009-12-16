;;; environ.el

(setq ring-bell-function 'ignore
      visible-bell nil
      column-number-mode t
      font-lock-maximum-decoration t
      inhibit-startup-message t
      transient-mark-mode t
      color-theme-is-global t
      delete-by-moving-to-trash t
      shift-select-mode t
      truncate-partial-width-windows nil
      uniquify-buffer-name-style 'forward
      whitespace-style '(trailing lines space-before-tab
                                  indentation space-after-tab)
      whitespace-line-column 80
      ediff-window-setup-function 'ediff-setup-windows-plain
      save-place-file (concat dotfiles-dir "places")
      x-select-enable-clipboard t
      interprogram-paste-function 'x-cut-buffer-or-selection-value

      mac-allow-anti-aliasing nil

      browse-url-browser-function 'browse-url-default-macosx-browser

      tramp-default-method "ssh")

(setq-default tab-width 4
              indent-tabs-mode t
              indicate-empty-lines nil
              imenu-auto-rescan t)

(prefer-coding-system 'utf-8)
(auto-compression-mode t)
(global-font-lock-mode t)
(recentf-mode 1)
(show-paren-mode 1)

;; GUI stuff
(when window-system
  (mouse-wheel-mode t)
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
  (tooltip-mode -1)
  (tool-bar-mode -1)
  (blink-cursor-mode t)
  (server-start))

;; Init ido
(ido-mode t)
(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-create-new-buffer 'always
      ido-use-filename-at-point t
      ido-max-prospects 10)


;; Init random seed
(random t)

;; Trim whitespace before
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Don't clutter up directories with files~
(setq backup-directory-alist `(("." . ,(expand-file-name
                                        (concat dotfiles-dir "backups")))))

;; Associate modes with file extensions
(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG$" . diff-mode))
(add-to-list 'auto-mode-alist '("\\.css$" . css-mode))
(add-to-list 'auto-mode-alist '("\\.xml$" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.html$" . html-mode))
(add-to-list 'auto-mode-alist '("\\.rhtml$" . html-mode))
(add-to-list 'auto-mode-alist '("\\.erl$" . erlang-mode))
(add-to-list 'auto-mode-alist '("\\.hrl$" . erlang-mode))
(add-to-list 'auto-mode-alist '("\\.lfe$" . lfe-mode))
(add-to-list 'auto-mode-alist '("\\.lfh$" . lfe-mode))
(add-to-list 'auto-mode-alist '("\\.go$" . go-mode))
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.proto$" . protobuf-mode))

;; Cosmetics
(set-face-font 'default "-apple-Anonymous_Pro-medium-normal-normal-*-11-*-*-*-m-0-iso10646-1")
(color-theme-initialize)
(color-theme-almost-monokai)

(eval-after-load 'diff-mode
  '(progn
     (set-face-foreground 'diff-added "green4")
     (set-face-foreground 'diff-removed "red3")))

(eval-after-load 'magit
  '(progn
     (set-face-foreground 'magit-diff-add "green3")
     (set-face-foreground 'magit-diff-del "red3")))

(defalias 'yes-or-no-p 'y-or-n-p)

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

;; Anthy, for Japanese input
;; (set-language-environment "Japanese")
;; (load-library "anthy")
;; (setq default-input-method "japanese-anthy")

(custom-set-variables
 '(gud-gdb-command-name "gdb --annotate=1")
 '(large-file-warning-threshold nil)
 '(quack-fontify-style nil)
 '(quack-default-program "/Library/Gambit-C/current/bin/tsi")
 '(quack-remap-find-file-bindings-p nil))

(provide 'environ)
