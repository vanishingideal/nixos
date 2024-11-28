$env.config = {
    show_banner: false,
    color_config: {
        separator: "#fe8019"      # bright_orange
        leading_trailing_space_bg: "#504945"  # dark2
        header: "#83a598"         # bright_blue
        date: "#d3869b"          # bright_purple
        filesize: "#fabd2f"      # bright_yellow
        row_index: "#8ec07c"     # bright_aqua
        bool: "#fb4934"          # bright_red
        int: "#d3869b"           # bright_purple
        duration: "#83a598"      # bright_blue
        range: "#8ec07c"         # bright_aqua
        float: "#d3869b"         # bright_purple 
        nothing: "#928374"       # gray
        binary: "#fb4934"        # bright_red
        cellpath: "#8ec07c"      # bright_aqua
        hints: "#7c6f64"         # dark4
	string: "white"       
	primitive_line: "white"

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

def create_left_prompt [] {
    let last_exit = $env.LAST_EXIT_CODE
    let prompt_char = if $last_exit == 0 {
        ";"
    } else {
        $"(ansi red);(ansi reset)"
    }
    $prompt_char
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

