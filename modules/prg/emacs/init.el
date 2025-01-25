(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("gnu" . "https://elpa.gnu.org/packages/")))
(setq package-refresh-contents nil)

;;; Basic Performance Tweaks
(setq gc-cons-threshold 80000000)            ; Adjusted GC threshold
(setq read-process-output-max (* 1024 1024))  ; Increase read process output

;;; Package Management
(setq use-package-always-ensure nil)   ; Auto-install packages
(setq package-check-signature nil)     ; Disable strict signature checking

;;; Org-bullets
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;;; Package Configurations
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package yasnippet
  :ensure t
  :config (yas-global-mode 1))

(use-package company
  :hook (prog-mode . company-mode)
  :config
  (setq company-minimum-prefix-length 1
        company-idle-delay 0.0))

(use-package evil
  :config (evil-mode 1))

(use-package emmet-mode
  :config
  (define-key emmet-mode-keymap (kbd "TAB") 'emmet-expand-line)
  (setq emmet-indentation 2
        emmet-move-cursor-between-quotes t)
  (add-to-list 'emmet-jsx-major-modes 'js-mode))

(use-package js2-mode
  :ensure t
  :mode "\\.js\\'"
  :hook ((js2-mode . yas-minor-mode)
         (js2-mode . company-mode)
         (js2-mode . flycheck-mode)))

(use-package lean4-mode
  :commands (lean4-mode))

(use-package org-roam
  :ensure t
  :custom
  (org-roam-completion-everywhere t)
  (org-roam-directory "/home/vanishingideal/.org-roam")
  :bind (("C-c n f" . org-roam-node-find)) ;; bind globally for testing
  :config
  (org-roam-setup))


(use-package fzf
  :bind
  (("C-c ff" . fzf)             ; general fuzzy find
   ("C-c fg" . fzf-git)          ; fuzzy search in git repo
   ("C-c fG" . fzf-git-grep)     ; git-aware grep
   ("C-c fr" . fzf-recentf)      ; fuzzy find recent files
   ("C-c fd" . fzf-directory))   ; directory search
  :config
  (setq fzf/args "-x --color bw --print-query --margin=1,0 --no-hscroll"
        fzf/executable "fzf"
        fzf/git-grep-args "-i --line-number %s"
        fzf/grep-command "grep -nrH"
        fzf/position-bottom t
        fzf/window-height 15))

;;; Basic UI Settings
(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)
(setq initial-buffer-choice t)

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "firefox")

(scroll-bar-mode -1)
(horizontal-scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(set-fringe-mode '(8 . 0))
(show-paren-mode 1)
(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'relative)
(setq ring-bell-function 'ignore)
(setq-default truncate-lines t)
(setq-default fill-column 79)
(add-hook 'text-mode-hook #'auto-fill-mode)

;;; Fonts
(set-face-attribute 'default nil :font "JetBrains Mono-9")
(setq-default antialiasing t)
(setq frame-resize-pixelwise t)

;;; Indentation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq-default standard-indent 2)

;;; Theming (with miasma-theme)
(use-package miasma-theme
  :ensure t
  :config
  (load-theme 'miasma t))

;;; Dired Configuration
(add-hook 'dired-mode-hook 'dired-hide-details-mode)

;;; Org-journal Configuration
(require 'org-journal)
(setq org-journal-dir "~/org/journal/")
(setq org-journal-date-format "%A, %d %B %Y")
(global-set-key (kbd "C-c C-j") 'org-journal-new-entry)

;;; Epub reader
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

;;; Launch envrc
(envrc-global-mode)

