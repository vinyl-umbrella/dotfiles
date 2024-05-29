(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org"   . "https://orgmode.org/elpa/")
                         ("elpa"  . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
        (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
        (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(load-theme 'monokai t)

(require 'smart-mode-line)
(require 'rainbow-delimiters)
(require 'diminish)
(require 'eglot)


(set-language-environment 'utf-8)
(prefer-coding-system 'utf-8)

;; initial message
(setq initial-scratch-message ""
      inhibit-startup-message t)

;; backup files
(setq make-backup-files nil
      auto-save-default nil
      delete-auto-save-files t)

;; final new line
(setq require-final-newline t)

;; rm trailing white space
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; hide minor mode
(use-package diminish
    :ensure t
    :init
    (diminish 'eldoc-mode "")
    (diminish 'company-mode "")
    )

;; scroll
(setq scroll-conservatively 1)

;; line num
(global-display-line-numbers-mode 1)

;; (setq linum-format "%4d ")
(setq-default display-line-numbers-width 4)
(set-face-attribute 'line-number nil
                    :foreground "gray50")

;; bar
;; (menu-bar-mode -1)
;; (tool-bar-mode 0)

;; auto pair bracket
(electric-pair-mode 1)
(show-paren-mode 1)

;; yes-or-no to y-or-n
(fset 'yes-or-no-p 'y-or-n-p)

;; tab width
(setq-default tab-width 4 indent-tabs-mode nil)

;; mute bell sound
(setq ring-bell-function 'ignore)

;; display time
(defvar display-time-format "%H:%M")
(defvar display-time-24hr-format t)
(display-time-mode t)

;; sml
(use-package smart-mode-line
    :config
    (progn
        (setq sml/show-encoding nil)
        (setq sml/theme 'respectful)
        (setq sml/no-confirm-load-theme t)
        (setq sml/modified-char "*")
        (setq sml/position-percentage-format nil)
        (setq sml/theme 'dark)

        ;; on error
        (setq ring-bell-function
            (lambda ()



              (let ((orig-fg (face-background 'mode-line)))
                (set-face-background 'mode-line "purple4")
                (run-with-idle-timer 0.1 nil
                                    (lambda (fg) (set-face-background 'mode-line fg))
                                    orig-fg))))

        ;; on save
        (add-hook 'after-save-hook
                (lambda ()
                    (let ((orig-fg (face-background 'mode-line)))
                    (set-face-background 'mode-line "dark green")
                    (run-with-idle-timer 0.2 nil
                                        (lambda (fg) (set-face-background 'mode-line fg))
                                        orig-fg))))

        (sml/setup)
    )
)

;; eglot
(use-package eglot
     :defer t
     ;; :bind (:map eglot-mode-map
     ;;             ("C-c l a" . eglot-code-actions)
     ;;             ("C-c l r" . eglot-rename)
     ;;             ("C-c l f" . eglot-format)
     ;;             ("C-c l d" . eldoc))
     :hook (eglot-managed-mode . (lambda () (flymake-mode -1)))
     :config
     (add-to-list 'eglot-server-programs '(python-mode . ("pyright-langserver" "--stdio")))
     (add-to-list 'eglot-server-programs '(go-mode . ("gopls")))

     (setq read-process-output-max (* 1024 1024))
     (push :documentHighlightProvider eglot-ignored-server-capabilities)
     (setq eldoc-echo-area-use-multiline-p nil))


;; company-mode の設定
(use-package company
     :ensure t
     :init
     (add-hook 'after-init-hook 'global-company-mode)
     :config
     (setq company-idle-delay 0.1
           company-minimum-prefix-length 1
           company-tooltip-align-annotations t
           company-tooltip-flip-when-above t))

;; Rainbow-delimiters
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(require 'cl-lib)
(require 'color)

; bracket color
(defun rainbow-delimiters-colors ()
       (interactive)
       (cl-loop
           for index from 1 to rainbow-delimiters-max-face-count
               do
                   (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
                   (cl-callf color-saturate-name (face-foreground face) 30))))
(add-hook 'emacs-startup-hook 'rainbow-delimiters-colors)

;; multi-term
;; (setq multi-term-program (getenv "$SHELL"))
;; (defun open-shell ()
;;   (interactive)
;;   (split-window-below)
;;   (enlarge-window 7)
;;   (other-window 1)
;;   (let ((term) (res))
;;     (if (or nil (null (setq term (dolist (buf (buffer-list) res)
;;                                    (if (string-match "*terminal<[0-9]+>*" (buffer-name buf))
;;                                        (setq res buf))))))
;;          (multi-term)
;;        (switch-to-buffer term))))

;; (define-key global-map (kbd "C-x C-@") 'open-shell)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(package-utils company diminish rainbow-delimiters monokai-theme smart-mode-line)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
