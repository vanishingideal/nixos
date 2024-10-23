{
  config,
  pkgs,
  epkgs,
  ...
}: {
  programs.emacs = {
    enable = true;
    extraPackages = epkgs:
      with epkgs; [
        use-package
        evil
        lsp-mode
        gruvbox-theme
        emmet-mode
        js2-mode
        prettier
        citar
        elfeed
        org-roam
        emacsql
        emacsql-sqlite
        pdf-tools
        vterm
        nix-mode
        neotree
        multiple-cursors
        company
      ];

    extraConfig = ''
      (setq gc-cons-threshold 100000000
            use-package-always-ensure t
            inhibit-startup-message t
            custom-file (expand-file-name "custom.el" user-emacs-directory)
            lsp-headerline-breadcrumb-enable-diagnostics nil
            display-line-numbers-type 'relative)

      (set-charset-priority 'unicode)
      (prefer-coding-system 'utf-8-unix)
      (set-language-environment "utf-8")
      (set-default-coding-systems 'utf-8)
      (scroll-bar-mode -1)
      (tool-bar-mode -1)
      (tooltip-mode -1)
      (menu-bar-mode -1)
      (global-display-line-numbers-mode t)
      (column-number-mode)

      (delete-selection-mode t)
      (setq-default c-basic-offset 2
                    tab-width 2
                    indent-tabs-mode nil
                    standard-indent 2)

      (require 'emmet-mode)
      (add-hook 'sgml-mode-hook 'emmet-mode)
      (add-hook 'css-mode-hook  'emmet-mode)
      (add-hook 'emmet-mode-hook (lambda () (setq emmet-indentation 2)))

      (define-key emmet-mode-keymap (kbd "TAB") 'emmet-expand-line)
      (setq emmet-move-cursor-between-quotes t)
      (add-to-list 'emmet-jsx-major-modes 'js-mode)

      (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

      (setenv "NODE_PATH" "/usr/local/lib/node_modules")
      (add-hook 'after-init-hook #'global-prettier-mode)

      (use-package evil
        :config
        (evil-mode 1))

      (use-package lsp-mode
        :hook ((python-mode typescript-mode c-mode) . lsp-deferred)
        :commands (lsp lsp-deferred))

      (use-package gruvbox-theme
        :config
        (load-theme 'gruvbox-dark-hard t)
        :custom
        (gruvbox-theme-use-bold-keywords t)
        (gruvbox-theme-use-bold-builtins t)
        (gruvbox-theme-use-italic-comments t))

      (use-package lean4-mode
        :commands (lean4-mode))

      (set-frame-font "fira code 10" nil t)

      (add-hook 'dired-mode-hook 'dired-hide-details-mode)

      (setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
            backup-by-copying t
            version-control t
            delete-old-versions t
            kept-new-versions 6
            kept-old-versions 2)

      (defun load-elfeed-feeds-from-file (file)
      (global-set-key (kbd "C-x w") 'elfeed)
      (setq elfeed-feeds (load-elfeed-feeds-from-file "~/.emacs.d/feeds.txt")))

      (use-package org-roam
      :ensure t
      :custom
      :bind (:map org-mode-map
            ("C-M-i" . completion-at-point))
      (org-roam-completion-everywhere t)
      (org-roam-directory "/home/vanishingideal/.org-roam")
      :config
      (org-roam-setup))

      ;; using bind here fails to initialise lazy-loading
      (global-set-key (kbd "C-c n l") 'org-roam-buffer-toggle)
      (global-set-key (kbd "C-c n f") 'org-roam-node-find)
      (global-set-key (kbd "C-c n i") 'org-roam-node-insert)
    '';
  };
}
