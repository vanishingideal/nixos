{
  config,
  pkgs,
  ...
}: {
  services.picom = {
    enable = true;
    fade = true;
    fadeSteps = [0.03 0.03];
    vSync = true;
  };
}
