{ config, pkgs, ... }:

{ programs.fish = {
    enable = true;

    functions = {
      cdr = ''
      set folder (begin
          fd . ~/dev/ride/apps/backend/edge-services -t d -d 1;
          fd . ~/dev/ride/apps/backend/backend-services -t d -d 1;
          fd . ~/dev/ride/apps/frontend/projects -t d -d 1;
          fd . ~/dev/ride/apps/native -t d -d 1;
          # fd . ~/dev/ride/packages -t d -d 1;
          echo "$HOME/dev/ride/apps/frontend";
          echo "$HOME/dev/ride/apps/lib";
          echo "$HOME/dev/ride";
      end | fzf);
      set service (basename $folder)

      cd $folder
      '';
      rr = ''
      set folder (begin
          fd . ~/dev/ride/apps/backend/edge-services -t d -d 1;
          fd . ~/dev/ride/apps/backend/backend-services -t d -d 1;
          fd . ~/dev/ride/apps/frontend/projects -t d -d 1;
          fd . ~/dev/ride/apps/native -t d -d 1;
          echo "$HOME/dev/ride/apps/frontend";
          echo "$HOME/dev/ride/apps/lib";
          echo "$HOME/dev/ride";
      end | fzf);
      
      if test -n "$folder"
          set service (basename $folder)
          cd $folder
          
          # Check if package.json exists
          if test -f "package.json"
              # Extract and format npm scripts for fzf
              set script_cmd (jq -r '.scripts | to_entries | .[] | "\(.key): \(.value)"' package.json | fzf)
              
              if test -n "$script_cmd"
                  # Extract just the script name before the colon
                  set script_name (string split ": " $script_cmd)[1]
                  if test -n "$script_name"
                      echo "Running: npm run $script_name"
                      npm run $script_name
                  end
              end
          end
      end
      '';
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
      localip = "ifconfig | grep \"inet \" | grep -v 127.0.0.1 | awk '{print $2}' | head -n 1";
      publicip = "curl -4 ifconfig.me";
      fzf = ''
      set -Ux FZF_DEFAULT_OPTS "
              --color=fg:#908caa,bg:#191724,hl:#ebbcba
              --color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
              --color=border:#403d52,header:#31748f,gutter:#191724
              --color=spinner:#f6c177,info:#9ccfd8
              --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"

      command fzf
      '';
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
      fish_add_path $ANDROID_HOME/emulator
      fish_add_path $ANDROID_HOME/platform-tools

      envsource ~/.env

      zoxide init fish | source
      fnm env --use-on-cd --shell fish | source
      rbenv init - | source
    '';

    shellAbbrs = {
      lg = "lazygit";
      g = "git";
      gco = "git checkout";
      frc = "source ~/.config/fish/**/*.fish";
      t = "todo.sh";
      p = "pnpm";
      pa = "pnpm add";
      pad = "pnpm add -D";
      pi = "pnpm install";
      px = "pnpm dlx";
    };

    plugins = [
      {
         name = "pnpm-shell-completion";
         src = pkgs.fetchFromGitHub {
           owner = "g-plane";
           repo = "pnpm-shell-completion";
           rev = "v0.5.4";
           sha512 = "e34eefb80400d1cd2a7e787cf47f0b48bdf767fa";
         };
      }
    ];
  };

  home.file.".config/fish/themes".source = ./themes;
}
