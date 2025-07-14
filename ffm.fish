function ffm
    set -l dir (pwd)
    
    while true
        # Create temp file for special commands
        set -l temp_file (mktemp)
        
        # Create prompt with abbreviated path (last 2 directories)
        set -l prompt_path (echo $dir | sed 's|.*/\([^/]*/[^/]*\)$|\1|')
        if test "$prompt_path" = "$dir"
            # If path is short, just remove leading slash if present
            set prompt_path (echo $dir | sed 's|^/||')
        end
        
        # Run fzf with search enabled by default
        set -l result (
            ls -A --color=always $dir \
            | sort \
            | fzf \
                --ansi \
                --preview "if test -d '$dir/{}'; then exa --color=always --icons --group-directories-first '$dir/{}' 2>/dev/null || ls -1 '$dir/{}' 2>/dev/null; else bat_output=\$(bat --color=always --style=plain --line-range=:20 '$dir/{}' 2>&1); if echo \"\$bat_output\" | grep -q 'Binary content'; then echo 'Preview not available'; else echo \"\$bat_output\" || head -20 '$dir/{}' 2>/dev/null || echo 'Preview not available'; fi; fi" \
                --preview-window=right:50%:wrap \
                --height=15 \
                --layout=reverse \
                --border=rounded \
                --bind "ctrl-j:down" \
                --bind "ctrl-k:up" \
                --bind "ctrl-h:execute(echo 'PARENT' > $temp_file)+abort" \
                --bind "ctrl-l:accept" \
                --bind "down:down" \
                --bind "up:up" \
                --bind "left:execute(echo 'PARENT' > $temp_file)+abort" \
                --bind "right:accept" \
                --bind "ctrl-c:abort" \
                --bind "esc:abort" \
                --footer "Nav with Ctrl+hjkl or arrows" \
                --pointer='▶' \
                --marker='●' \
                --prompt="$prompt_path/")
        
        # Check for special commands
        if test -f $temp_file
            set -l command (cat $temp_file)
            rm $temp_file
            
            if test "$command" = "PARENT"
                set dir (realpath "$dir/..")
                continue
            end
        end
        
        # Clean up temp file
        test -f $temp_file && rm $temp_file
        
        # Handle normal exit (ctrl-c, esc)
        if test -z "$result"
            cd "$dir"
            return
        end
        
        # Strip color codes from result to get actual filename
        set -l clean_result (echo $result | sed 's/\x1b\[[0-9;]*m//g')
        
        # Handle selection
        set -l path "$dir/$clean_result"
        if test -d "$path"
            set dir (realpath "$path")
        else if test -f "$path"
            xdg-open "$path" >/dev/null 2>&1 &
        end
    end
end
