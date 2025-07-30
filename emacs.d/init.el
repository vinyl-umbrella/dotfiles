(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)

;; treemacs
(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  (with-eval-after-load 'treemacs
    (define-key treemacs-mode-map [mouse-1] #'treemacs-single-click-expand-action))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t d"   . treemacs-select-directory)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

;; icons
(use-package nerd-icons
  :ensure t)
(use-package treemacs-nerd-icons
  :ensure t
  :after (treemacs nerd-icons)
  :config
  (treemacs-load-theme "nerd-icons"))
(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)

;; company
(use-package company
  :ensure t
  :after company-statistics

  :init
  (global-company-mode)
  :config
  (setq completion-ignore-case t)
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 2)
  (setq company-selection-wrap-around t))

(use-package company-statistics
  :ensure t
  :init
  (company-statistics-mode))

;; lsp
(use-package eglot
  :hook
  (html-mode . eglot-ensure)
  (go-mode . eglot-ensure)
  (typescript-mode . eglot-ensure)
  (python-mode . eglot-ensure)
  )

;; theme
(use-package treesit-auto
  :ensure t
  :config
  (setq treesit-auto-install t)
  (global-treesit-auto-mode))

(use-package treesit
  :config
  (setq treesit-font-lock-level 4))

(use-package nord-theme
  :ensure t
  :config
  (load-theme 'nord t))

;; initial message
(setq initial-scratch-message ""
      inhibit-startup-message t)

;; misc
;(setq debug-on-error t)
(setopt tab-always-indent 'complete)
(unless (display-graphic-p)
  (menu-bar-mode -1))
(show-paren-mode t)

;; which key
(which-key-mode 1)

;; use space for indent and size 4
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;; blink cursor
(with-eval-after-load 'frame
  (blink-cursor-mode -1))

;; sync clipboard
(setq select-enable-clipboard t)

;; mouse scroll
(add-hook 'tty-setup-hook #'xterm-mouse-mode)
(setq scroll-consErvatively 1)

;; short y-or-n
(setq use-short-answers t)

;; auto pair bracket
(electric-pair-mode 1)

;; utf-8
(set-language-environment 'utf-8)
(prefer-coding-system 'utf-8)

;; rm trail spaces
(setq require-final-newline t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; backup files
(setq make-backup-files nil
      auto-save-default nil
      delete-auto-save-files t)

;; end
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("5a4cdc4365122d1a17a7ad93b6e3370ffe95db87ed17a38a94713f6ffe0d8ceb"
     default))
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
