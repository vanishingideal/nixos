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
        org-bullets
        yasnippet
        envrc
        org-journal
        emmet-mode
        js2-mode
        citar
        nov
        fzf
        flycheck
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
      (load "/etc/nixos/modules/prg/emacs/init.el")
    '';
  };
}
