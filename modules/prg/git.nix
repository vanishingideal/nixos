{
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    userName = "vanishingideal";
    userEmail = "vanishingideal@protonmail.com";
    extraConfig = {
      github.user = "vanishingideal";
      credential.helper = "${
        pkgs.git.override {withLibsecret = true;}
      }/bin/git-credential-libsecret";
      core.editor = "emacs";
    };
  };
}
