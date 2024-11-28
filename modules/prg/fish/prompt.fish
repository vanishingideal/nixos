set fish_greeting
function fish_prompt
  set -l last_status $status

  if test $last_status -eq 0
    set prompt_char ";"
  else
    set prompt_char (set_color red)";"(set_color normal)
  end

  echo -n "$prompt_char "
end
