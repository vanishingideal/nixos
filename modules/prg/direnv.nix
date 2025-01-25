{
  config,
  pkgs,
  ...
}: {
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    silent = true;
    enableNushellIntegration = true;
    config.global.hide_env_diff = true;
  };
}
