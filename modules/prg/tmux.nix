{
  config,
  pkgs,
  ...
}: {
  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      continuum
      resurrect
      sensible
      yank
      vim-tmux-navigator
    ];
    terminal = "tmux-256color";
    mouse = true;
    keyMode = "vi";
    extraConfig = ''
      unbind C-b
      set -g prefix C-Space
      bind-key C-Space send-prefix
      bind-key = select-layout even-horizontal
      set -g set-clipboard on
      bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -in -selection clipboard"
      set-option -g status-position top
      set -g base-index 1
      set -g pane-base-index 1
      set -g renumber-windows on
      set -g status-style bg=default

      set -g status-left-length 32
      set -g status-right-length 0

      set -g status-left "#[fg=red]#{session_name}#[fg=white] | "
      set -g status-right ""

      set -g window-status-format "#[fg=white]#I#[fg=white]·#[fg=white]#W#[fg=white]"
      set -g window-status-current-format "#[fg=white]#I#[fg=white]·#[fg=white]#W#[fg=white]"

      set -g pane-border-style fg=color000
      set -g pane-active-border-style "fg=color000"

      set-option -g detach-on-destroy off
      set-environment -g DISPLAY :0
    '';
  };
}
