{
  config,
  pkgs,
  epkgs,
  ...
}: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs30.override {
      withGTK3 = true;
    };

    extraPackages = epkgs:
      with epkgs; [
        use-package
        evil
        org-bullets
        yasnippet
        envrc
        org-journal
        emmet-mode
        elfeed
        elfeed-goodies
        elfeed-org
        js2-mode
        citar
        nov
        fzf
        flycheck
        org-roam
        emacsql
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
