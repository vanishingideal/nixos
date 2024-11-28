{
  config,
  pkgs,
  ...
}: {
  programs.nushell = {
    enable = true;
    extraConfig = ''
      def create_left_prompt [] {
        let last_exit = $env.LAST_EXIT_CODE
        let prompt_char = if $last_exit == 0 { 
          ";" 
        } else { 
          $"(ansi red);(ansi reset)" 
        }
        $prompt_char
      }

      $env.PROMPT_COMMAND = { || create_left_prompt }
      $env.PROMPT_INDICATOR = " "
    '';
  };
}
