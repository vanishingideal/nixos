{pkgs, ...}: {
  programs.nixvim = {
    enable = true;
    viAlias = true;
    extraPlugins = [pkgs.vimPlugins.miasma-nvim];
    colorscheme = "miasma";

    opts = {
      number = true;
      relativenumber = true;
      tabstop = 2;
      expandtab = true;
      smartindent = true;
      shiftwidth = 2;
      fillchars = {eob = " ";};
    };
  };
}
