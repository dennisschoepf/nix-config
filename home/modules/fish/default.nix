{
  programs.fish = {
    enable = true;

    functions = {
      ff = ''
        set RG_PREFIX "rg --column --line-number --no-heading --color=always --smart-case "
        set INITIAL_QUERY "$argv"
        fzf --ansi --disabled --query "$INITIAL_QUERY" \
          --bind "start:reload:$RG_PREFIX {q}" \
          --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
          --delimiter : \
          --preview 'bat --color=always {1} --highlight-line {2}' \
          --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
          --bind 'enter:become(nvim {1} +{2})'
      '';
      envsource = ''
        for line in (cat $argv | grep -v '^#')
            set item (string split -m 1 '=' $line)
            set -gx $item[1] $item[2]
        end
      '';
      fish_greeting = "fortune -a";
      resize_images = ''
        # Resize all JPG images in the current directory and its subdirectories
        # Usage: resize_images [percentage]
        # Example: resize_images 20 - resizes all images to 20% of original size
        # If no percentage is provided, defaults to 40%
        
        set -l percentage $argv[1]
        if test -z "$percentage"
          set percentage 40
        end
        
        for img in (find . -type f -name "*.JPG")
          set original_size (stat -f %z "$img")
          magick convert "$img" -resize "$percentage%" "$img"
          set new_size (stat -f %z "$img")
          echo "Processed $img"
          echo "Original size: $original_size bytes"
          echo "New size: $new_size bytes"
          echo "---"
        end
      '';
      localip = "	ifconfig | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}' | head -n 1";
      publicip = "curl -4 ifconfig.me";
    };

    interactiveShellInit = ''
      fish_config theme choose "Rosé Pine"

      set hn (prompt_hostname)
      set fish_cursor_default     block      blink
      set fish_cursor_insert      line       blink
      set fish_cursor_replace_one underscore blink
      set fish_cursor_visual      block
      set fish_vi_force_cursor 1
      fish_vi_key_bindings

      fish_add_path /run/current-system/sw/bin
      fish_add_path /opt/homebrew/bin

      envsource ~/.env

      zoxide init fish | source
      fnm env --use-on-cd --shell fish | source
    '';

    shellAbbrs = {
      lg = "lazygit";
      g = "git";
      j = "jrnl";
      frc = "source ~/.config/fish/**/*.fish";
      t = "todo.sh";
    };
  };

  home.file.".config/fish/themes".source = ./themes;
}
