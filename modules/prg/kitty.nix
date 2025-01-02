{
  config,
  pkgs,
  ...
}: {
  programs.kitty = {
    enable = true;
    font = {
      name = "Jetbrains Mono";
      size = 9;
    };
    extraConfig = ''
      shell nu
      mouse_hide_wait 0.25
      confirm_os_window_close 0
      copy_on_select yes
      mouse_map ctrl+left press ungrabbed,grabbed mouse_click_url
      detect_urls yes
      copy_on_select yes
      show_hyperlink_targets yes
      open_url_with firefox
      enable_audio_bell no
      cursor_shape underline
      disable_ligatures never
      tab_bar_style powerline
      font_hinting none
      include /etc/nixos/modules/prg/kitty/gruvbox_dark.conf
    '';
  };
}
