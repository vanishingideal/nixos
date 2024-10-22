set fish_greeting
function fish_prompt
  set -l last_status $status

  if test $last_status -eq 0
    set prompt_char ";"
  else
    set prompt_char (set_color red)";"(set_color normal)
  end

  if fish_is_root_user
    set prompt_char "#"
  end

  echo -n "$prompt_char "
end
