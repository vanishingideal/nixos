{
  config,
  pkgs,
  epkgs,
  ...
}: {
  programs.zathura = {
    enable = true;
    extraConfig = ''
      map r reload
      map p print
      map J zoom out
      map i recolor
      map K zoom in
      map R rotate
      unmap f
      map f toggle_fullscreen
      map [fullscreen] f toggle_fullscreen

      set adjust-open "best-fit"
      set pages-per-row 1

      set scroll-page-aware "true"
      set scroll-full-overlap 0.01
      set scroll-step 100

      set zoom-min 10
      set guioptions ""

      set font "Jetbrains Mono 9.5"

      set inputbar-bg "#000000"
      set inputbar-fg "#ffffff"

      set completion-bg "#000000"
      set completion-fg "#ffffff"

      set completion-highlight-bg "#000000"
      set completion-highlight-fg "#ffffff"

      set recolor true
      set recolor-keephue true
    '';
  };
}
