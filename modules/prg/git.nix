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
      user.signingkey = "/home/vanishingideal/.ssh/github.pub";
      commit.gpgsign = true;
      github.user = "vanishingideal";
      core.editor = "emacs";
      credential = {
        helper = ["manager" "cache --timeout 21600"];
        username = "vanishingideal";
        credentialStore = "cache";
      };
      delta = {
        enable = true;
        options = {
          side-by-side = true;
          syntax-theme = "none";
        };
      };
      fetch.prune = true;
      init.defaultBranch = "main";
      pull.rebase = false;
      gpg.format = "ssh";
      rebase = {
        autoStash = true;
        autoSquash = true;
        abbreviateCommands = true;
        missingCommitsCheck = "warn";
      };
    };
  };
}
