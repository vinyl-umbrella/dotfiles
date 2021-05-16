(require 'package)
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")
        ("org" . "https://orgmode.org/elpa/")
        ("marmalade" . "https://marmalade-repo.org/packages/")
        ))

(package-initialize)

(unless (package-installed-p 'company)
  (package-refresh-contents)
  (package-install 'company))
(unless (package-installed-p 'company-jedi)
  (package-refresh-contents)
  (package-install 'company-jedi))
(unless (package-installed-p 'smart-mode-line)
  (package-refresh-contents)
  (package-install 'smart-mode-line))
(unless (package-installed-p 'diminish)
  (package-refresh-contents)
  (package-install 'diminish))
(unless (package-installed-p 'rainbow-delimiters)
  (package-refresh-contents)
  (package-install 'rainbow-delimiters))
(unless (package-installed-p 'flycheck)
  (package-refresh-contents)
  (package-install 'flycheck))
(unless (package-installed-p 'multi-term)
  (package-refresh-contents)
  (package-install 'multi-term))
(when (package-installed-p 'monokai-theme)
  (load-theme 'monokai t))


(require 'company)
(require 'jedi-core)
(require 'smart-mode-line)
(require 'rainbow-delimiters)
(require 'flycheck)
(require 'diminish)
(require 'multi-term)
;(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")


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

;; delete tail white space
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; hide minor mode
(diminish 'eldoc-mode "")
(diminish 'company-mode "")

;; scroll
(setq scroll-conservatively 1)

;; line num
(global-linum-mode t)
(setq linum-format "%4d ")
(set-face-background 'linum  "gray24")

;; bar
(tool-bar-mode 0)
(menu-bar-mode 0)

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
(defvar display-time-format " %H:%M")
(defvar display-time-24hr-format t)
(display-time-mode t)

;; sml
(column-number-mode t)
(line-number-mode t)
(setq sml/no-confirm-load-theme t
      sml/modified-char "*"
      sml/show-encoding t
      sml/position-percentage-format ""
      sml/theme 'dark
      )
; on error
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

;; company
(global-company-mode)
(setq company-idle-delay 0
      company-minimum-prefix-length 2
      company-selection-wrap-around 1)

(setq jedi:complete-on-dot t)
(setq jedi:use-shortcuts t)
(add-hook 'python-mode-hook 'jedi:setup)
(add-to-list 'company-backends 'company-jedi)

;; flycheck
(global-flycheck-mode)


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
(setq multi-term-program (getenv "$SHELL"))
(defun open-shell ()
  (interactive)
  (split-window-below)
  (enlarge-window 7)
  (other-window 1)
  (let ((term) (res))
    (if (or nil (null (setq term (dolist (buf (buffer-list) res)
                                   (if (string-match "*terminal<[0-9]+>*" (buffer-name buf))
                                       (setq res buf))))))
         (multi-term)
       (switch-to-buffer term))))

(define-key global-map (kbd "C-x C-\\") 'open-shell)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (multi-term diminish company-jedi flycheck rainbow-delimiters monokai-theme smart-mode-line company))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
