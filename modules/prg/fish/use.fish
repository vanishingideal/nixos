function use
    nix-shell -p $argv[1] --run "$argv[2..-1]"
end

