{ config, pkgs, ... }:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
      };
      
      background = [
        {
          path = "screenshot";
          blur_passes = 1;
          blur_size = 7;
          noise = 1.17e-2;
        }
      ];

      label = [
        {
          monitor = "DP-5";
          text = "$TIME";
          color = "rgba(242, 243, 244, 0.75)";
          font_size = 95;
          font_family = "JetBrains Mono";
          position = "0, 300";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "DP-5";
          text = ''cmd[update:1000] echo $(date +"%A, %B %d")'';
          color = "rgba(242, 243, 244, 0.75)";
          font_size = 22;
          font_family = "JetBrains Mono";
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
      ];

      image = {
        monitor = "DP-5";
        path = "$HOME/.config/Nixos/Modules/home-manager/profile.png";
        position = "0, 50";
        halign = "center";
        valign = "center";
      };

      input-field = [
        {
          size = "200, 50";
          position = "0, -100";
          monitor = "DP-5";
          dots_size = 0.2;
          dots_spacing = 0.35;
          dots_center = true;
          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(0, 0, 0, 0.2)";
          font_color = "rgba(177, 228, 242, 0.9)";
          rounding = -1;
          fade_on_empty = false;
          outline_thickness = 2;
          placeholder_text = ''Password...'';
          shadow_passes = 2;
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
