source "./gruvbox-dark-hard.nu"

$env.config = {
  show_banner: false,
  table: {
    mode: light
  }
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

$env.LS_COLORS = (vivid generate gruvbox-dark-hard | str trim)
$env.PROMPT_COMMAND_RIGHT = ""
$env.PROMPT_MULTILINE_INDICATOR = ""

def encrypt [input_file: string, output_file: string, password: string] {
    ^openssl aes-256-cbc -pbkdf2 -salt -in $input_file -out $output_file -pass $"pass:($password)"
}

def decrypt [input_file: string, output_file: string, password: string] {
    ^openssl aes-256-cbc -pbkdf2 -salt -d -in $input_file -out $output_file -pass $"pass:($password)"
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
$env.MANPAGER = "nvim +Man!"
