{
  services.homepage-dashboard = {
    enable = true;
    listenPort = 9001; 
    allowedHosts = "home.dnsc.io";
    settings = {
      theme = "dark";
      background = {
        image = "https://i.ibb.co/v6FjzW5V/winter.png";
        opacity = 40;
        brightness = 50;
      };
    };
    services = [
      {
        "VPS" = [
          {
            "Vaultwarden" = {
              href = "https://vault.dnsc.io";
              icon = "vaultwarden.png";
            };
          }
          {
            "Uptime Kuma" = {
              href = "https://uptime.dnsc.io";
              icon = "uptime-kuma.png";
            };
          }
          {
            "Slides" = {
              href = "https://uptime.dnsc.io";
              icon = "slidev.png";
            };
          }
        ];
      }
      {
        "Homelab" = [
          {
            "Jellyfin" = {
              href = "http://100.103.199.4:8096";
              icon = "jellyfin.png";
            };
          }
          {
            "Syncthing" = {
              href = "http://100.103.199.4:8384";
              icon = "syncthing.png";
            };
          }
        ];
      }
    ];
    bookmarks = [
      {
        Tools = [
          {
            Fastmail = [
              {
                abbr = "FM";
                href = "https://app.fastmail.com";
              }
            ];
          }
          {
            YNAB = [
              {
                abbr = "YN";
                href = "https://app.ynab.com";
              }
            ];
          }
        ];
      }
      {
        Dev = [
          {
            Codeberg = [
              {
                abbr = "CB";
                href = "https://codeberg.org";
              }
            ];
          }
          {
            Github = [
              {
                abbr = "GH";
                href = "https://github.com/dennisschoepf";
              }
            ];
          }
        ];
      }
      {
        Entertainment = [
          {
            YouTube = [
              {
                abbr = "YT";
                href = "https://youtube.com";
              }
            ];
          }
          {
            Twitch = [
              {
                abbr = "TW";
                href = "https://twitch.tv";
              }
            ];
          }
          {
            Overcast = [
              {
                abbr = "OC";
                href = "https://overcast.fm";
              }
            ];
          }
        ];
      }
    ];
  };
}
