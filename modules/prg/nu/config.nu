source "./gruvbox-dark-hard.nu"

$env.config = {
  show_banner: false,
  hooks: {
    pre_prompt: [{ ||
      if (which direnv | is-empty) {
        return
      }

      direnv export json | from json | default {} | load-env
        if 'ENV_CONVERSIONS' in $env and 'PATH' in $env.ENV_CONVERSIONS {
        $env.PATH = do $env.ENV_CONVERSIONS.PATH.from_string $env.PATH
      }
    }]
  }
}

def create_left_prompt [] {
    let last_exit = $env.LAST_EXIT_CODE
    let prompt_char = ";"

    if $last_exit == 0 {
        $"(ansi white)($prompt_char)(ansi reset)"
    } else {
        $"(ansi red)($prompt_char)(ansi reset)"
    }
}

def rebuild [] {
    cd /etc/nixos
    sudo nixos-rebuild switch --flake .#default
}

def gc [] { 
    nh clean all 
}

def e [...args] {
    emacsclient -t ...$args
}

def cc [file: string] {
    let outfile = ($file | split row '.' | first)
    gcc -Wall -Werror -Wextra -pedantic -std=gnu89 -g $file -o $outfile
}

def yt [url: string] {
    yt-dlp --cookies-from-browser firefox -f ba -x $url
}

def pbcopy [] {
    xclip -selection clipboard
}

def pbpaste [] {
    xclip -selection clipboard -o
}

$env.PROMPT_COMMAND = { || create_left_prompt }
$env.PROMPT_INDICATOR = " "

