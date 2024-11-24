{...}: {
  programs.nixvim = {
    enable = true;
    viAlias = true;
    colorschemes.gruvbox.enable = true;
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
