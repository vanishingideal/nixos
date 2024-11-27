{
  config,
  pkgs,
  epkgs,
  ...
}: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs30;
    extraPackages = epkgs:
      with epkgs; [
        use-package
        evil
        lsp-mode
        lsp-ui
        gruvbox-theme
        yasnippet
        envrc
        org-journal
        emmet-mode
        js2-mode
        citar
        fzf
        elfeed
        org-roam
        emacsql
        emacsql-sqlite
        pdf-tools
        vertico-posframe
        vterm
        nix-mode
        neotree
        multiple-cursors
        company
      ];

    extraConfig = ''
      ;;; Basic Performance Tweaks
      (setq gc-cons-threshold 100000000)            ; Increase garbage collection threshold
      (setq read-process-output-max (* 1024 1024))  ; Increase read process output

      ;;; Package Management
      (setq use-package-always-ensure t)   ; Auto-install packages

      ;;; Basic UI Settings
      (setq inhibit-startup-message t)     ; Disable startup message
      (scroll-bar-mode -1)                 ; Disable visible scrollbar
      (horizontal-scroll-bar-mode -1)      ; Disable horizontal scrollbar
      (tool-bar-mode -1)                   ; Disable the toolbar
      (tooltip-mode -1)                    ; Disable tooltips
      (menu-bar-mode -1)                   ; Disable the menu bar
      (set-fringe-mode '(8 . 0))           ; Set left fringe to 8 pixels
      (show-paren-mode 1)                  ; Show matching parentheses
      (global-display-line-numbers-mode t) ; Turns on line numbers for all buffers
      (setq display-line-numbers-type 'relative)
      (setq ring-bell-function 'ignore)    ; Who wants audible text editors?

      ;;; Fonts
      (set-face-attribute 'default nil
        :font "JetBrains Mono"
        :height 90
        :weight 'medium)

      ;;; Indentation
      (setq-default indent-tabs-mode nil)  ; use spaces, not tabs
      (setq-default tab-width 2)           ; set tab width to 2 spaces
      (setq-default standard-indent 2)     ; default indentation

      ;;; Yasnippet
      (use-package yasnippet
        :ensure t
        :config
        (yas-global-mode 1))

      ;;; Company
      (use-package company
        :hook (prog-mode . company-mode)
        :config
        (setq company-minimum-prefix-length 1
              company-idle-delay 0.0
              company-backends '((company-lsp company-files company-capf)))) ; ensure lsp backend

      ;;; LSP Configuration
      (use-package lsp-mode
        :ensure t
        :hook ((js2-mode . lsp)
               (typescript-mode . lsp))
        :commands lsp
        :config
        (setq lsp-headerline-breadcrumb-enable-diagnostics nil))

      (use-package lsp-ui
        :commands lsp-ui-mode
        :config
        (setq lsp-ui-doc-enable t
              lsp-ui-doc-position 'at-point
              lsp-ui-sideline-show-code-actions t))

      ;;; Evil Mode
      (use-package evil
        :config
        (evil-mode 1))

      ;;; Emmet Configuration
      (require 'emmet-mode)
      (add-hook 'sgml-mode-hook 'emmet-mode)
      (add-hook 'css-mode-hook  'emmet-mode)
      (add-hook 'emmet-mode-hook (lambda () (setq emmet-indentation 2)))
      (define-key emmet-mode-keymap (kbd "TAB") 'emmet-expand-line)
      (setq emmet-move-cursor-between-quotes t)
      (add-to-list 'emmet-jsx-major-modes 'js-mode)

      ;;; JavaScript Configuration
      (use-package js2-mode
        :ensure t
        :mode "\\.js\\'"
        :hook ((js2-mode . yas-minor-mode)
               (js2-mode . company-mode)
               (js2-mode . lsp)))

      (setenv "NODE_PATH" "/usr/local/lib/node_modules")

      ;;; Lean4 Mode
      (use-package lean4-mode
        :commands (lean4-mode))

      ;;; Dired Configuration
      (add-hook 'dired-mode-hook 'dired-hide-details-mode)

      ;;; Elfeed Configuration
      (defun load-elfeed-feeds-from-file (file)
        (global-set-key (kbd "C-x w") 'elfeed)
        (setq elfeed-feeds (load-elfeed-feeds-from-file "~/.emacs.d/feeds.txt")))

      ;;; Org-journal
      (setq org-journal-dir "~/org/journal/")
      (setq org-journal-date-format "%A, %d %B %Y")
      (require 'org-journal)

      ;;; Org-roam Configuration
      (use-package org-roam
        :ensure t
        :custom
        (org-roam-completion-everywhere t)
        (org-roam-directory "/home/vanishingideal/.org-roam")
        :bind (:map org-mode-map
                    ("C-M-i" . completion-at-point))
        :config
        (org-roam-setup))

      ;; Org-roam keybindings
      (global-set-key (kbd "C-c n l") 'org-roam-buffer-toggle)
      (global-set-key (kbd "C-c n f") 'org-roam-node-find)
      (global-set-key (kbd "C-c n i") 'org-roam-node-insert)

      ;;; Theme Configuration
      (use-package gruvbox-theme
        :config
        (load-theme 'gruvbox-dark-hard t)
        :custom
        (gruvbox-theme-use-bold-keywords t)
        (gruvbox-theme-use-bold-builtins t)
        (gruvbox-theme-use-italic-comments t))

      ;;; FZF
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

      ;;; JS-specific indentation
      (setq js-indent-level 2)

      ;;; Launch envrc
      (envrc-global-mode)
    '';
  };
}
