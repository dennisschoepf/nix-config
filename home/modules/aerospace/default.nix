{
  services.aerospace = {
    enable = true;
    settings = {
      accordion-padding = 25;
      gaps = {
        outer.left = 8;
        outer.bottom = 8;
        outer.top = 8;
        outer.right = 8;
      };
      workspace-to-monitor-force-assignment = {
        "1" = "main";
        "2" = "main";
        "3" = "main";
        "4" = "main";
        "5" = "secondary";
        "6" = "secondary";
      };
      mode.main.binding = {
        alt-h = "focus left";
        alt-j = "focus down";
        alt-k = "focus up";
        alt-l = "focus right";
        alt-shift-h = "move left";
        alt-shift-j = "move down";
        alt-shift-k = "move up";
        alt-shift-l = "move right";
        alt-comma = "layout tiles horizontal vertical";
        alt-period = "layout accordion horizontal vertical";
        alt-f = "fullscreen";
        alt-1 = "workspace 1";
        alt-2 = "workspace 2";
        alt-3 = "workspace 3";
        alt-4 = "workspace 4";
        alt-5 = "workspace 5";
        alt-6 = "workspace 6";
        alt-shift-1 = [ "move-node-to-workspace 1" "workspace 1" ];
        alt-shift-2 = [ "move-node-to-workspace 2" "workspace 2" ];
        alt-shift-3 = [ "move-node-to-workspace 3" "workspace 3" ];
        alt-shift-4 = [ "move-node-to-workspace 4" "workspace 4" ];
        alt-shift-5 = [ "move-node-to-workspace 5" "workspace 5" ];
        alt-shift-6 = [ "move-node-to-workspace 6" "workspace 6" ];
        alt-tab = "workspace-back-and-forth";
        alt-shift-tab = "move-workspace-to-monitor --wrap-around next";
      };
    };
  };
}
