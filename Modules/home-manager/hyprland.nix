{ config, pkgs, ... }:
#Here is where we config our WM.
#first is your startup script, this applications are launched when you launch hyprland.
let
  start-sh = pkgs.pkgs.writeShellScriptBin "start" ''
    hyprpaper &
    
    dunst &

    hypridle &

    hyprctl dispatch workspace 1 &

    waybar 

  '';
in
{
 wayland.windowManager.hyprland = { 
   enable = true;
   settings = {
     ecosystem = {
       "no_update_news" = "true";
     };
     monitor = [
       "DP-5, preferred,0x0, 1"
     ];
     "$terminal" = "kitty -1"; # Your terminal
     "$fileManager" = "dolphin"; # Your FileManager
     "$menu" = "rofi -show drun -show-icons"; # Your Application Launcher

     exec-once = ''${start-sh}/bin/start'';

     env = [
       #"HYPRCURSOR_SIZE,24"
       #"HYPRCURSOR_THEME,Duccursor"
       #"WLR_NO_HARDWARE_CURSORS,1"
       #"XCURSOR_THEME,Duccursor"
       "XCURSOR_SIZE,24"
     ];

     general = {
       "gaps_in" = "3";
       "gaps_out" = "2,5,6,5"; 
       "border_size" = "0";
       "resize_on_border" = "false";
       "allow_tearing" = "false";
       layout = "dwindle";
     };

     decoration = {
       rounding = "10";
       "rounding_power" = "2";
       "active_opacity" = "1.0";
       "inactive_opacity" = "0.9";
       shadow = {
         enabled = "true";
         range = "4";
         "render_power" = "3";
       };
       blur = {
         enabled = "true";
         size = "3";
         passes = "1";
         vibrancy = "0.1696";
       };
     };

     animations = {
       enabled = "yes, please :)";
       bezier = [
         "easeOutQuint,0.23,1,0.32,1"
         "easeInOutCubic,0.65,0.05,0.36,1"
         "linear,0,0,1,1"
         "almostLinear,0.5,0.5,0.75,1.0"
         "quick,0.15,0,0.1,1"
       ];
       animation = [
         "global, 1, 10, default"
         "border, 1, 5.39, easeOutQuint"
         "windows, 1, 4.79, easeOutQuint"
         "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
         "windowsOut, 1, 1.49, linear, popin 87%"
         "fadeIn, 1, 1.73, almostLinear"
         "fadeOut, 1, 1.46, almostLinear"
         "fade, 1, 3.03, quick"
         "layers, 1, 3.81, easeOutQuint"
         "layersIn, 1, 4, easeOutQuint, fade"
         "layersOut, 1, 1.5, linear, fade"
         "fadeLayersIn, 1, 1.79, almostLinear"
         "fadeLayersOut, 1, 1.39, almostLinear"
         "workspaces, 1, 1.94, almostLinear, fade"
         "workspacesIn, 1, 1.21, almostLinear, fade"
         "workspacesOut, 1, 1.94, almostLinear, fade"
       ];
     };

     dwindle = {
       pseudotile = "true"; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
       "preserve_split" = "true"; # You probably want this
     };
     master = {
       "new_status" = "master";
     };

     misc = {
      "force_default_wallpaper" = "-1"; # Set to 0 or 1 to disable the anime mascot wallpapers
     };

     input = {
       "kb_layout" = "us";
       "follow_mouse" = "1";
       "sensitivity" = "0"; # -1.0 - 1.0, 0 means no modification.
       touchpad = {
         "natural_scroll" = "false";
       };
     };

     gestures = {
       "workspace_swipe" = "false";
     };

     device = {
       name = "epic-mouse-v1";
       sensitivity = "-0.5";
     };

     "$mainMod" = "SUPER"; # Sets "Windows" key as main modifier

     bind = [
       "$mainMod, RETURN, exec, $terminal"
       "$mainMod, Q, killactive,"
       "$mainMod, M, exit,"
       "$mainMod, E, exec, $fileManager"
       "$mainMod, V, togglefloating,"
       "$mainMod, D, exec, $menu"
       "$mainMod, P, pseudo," # dwindle
       "$mainMod, R, togglesplit," # dwindle
       "$mainMod, F, fullscreen"
       "$mainMod, G, fullscreen, 1"
       "$mainMod, T, fullscreenstate, 0 2"
       "$mainMod, H, movefocus, l"
       "$mainMod, L, movefocus, r"
       "$mainMod, I, movefocus, u"
       "$mainMod, J, movefocus, d"
       "$mainMod, 1, workspace, 1"
       "$mainMod, 2, workspace, 2"
       "$mainMod, 3, workspace, 3"
       "$mainMod, 4, workspace, 4"
       "$mainMod, 5, workspace, 5"
       "$mainMod, 6, workspace, 6"
       "$mainMod, 7, workspace, 7"
       "$mainMod, 8, workspace, 8"
       "$mainMod, 9, workspace, 9"
       "$mainMod, 0, workspace, 10"
       "$mainMod SHIFT, 1, movetoworkspace, 1"
       "$mainMod SHIFT, 2, movetoworkspace, 2"
       "$mainMod SHIFT, 3, movetoworkspace, 3"
       "$mainMod SHIFT, 4, movetoworkspace, 4"
       "$mainMod SHIFT, 5, movetoworkspace, 5"
       "$mainMod SHIFT, 6, movetoworkspace, 6"
       "$mainMod SHIFT, 7, movetoworkspace, 7"
       "$mainMod SHIFT, 8, movetoworkspace, 8"
       "$mainMod SHIFT, 9, movetoworkspace, 9"
       "$mainMod SHIFT, 0, movetoworkspace, 10"
       "$mainMod, S, togglespecialworkspace, magic"
       "$mainMod SHIFT, S, movetoworkspace, special:magic"
       "$mainMod, mouse_down, workspace, e+1"
       "$mainMod, mouse_up, workspace, e-1"
       "$mainMod, B, togglespecialworkspace, magic"
       "$mainMod, B, movetoworkspace, +0"
       "$mainMod, B, togglespecialworkspace, magic"
       "$mainMod, B, movetoworkspace, special:magic"
       "$mainMod, B, togglespecialworkspace, magic"
       "$mainMod, W, togglespecialworkspace, 2, magic"
       "$mainMod, W, movetoworkspace, +0"
       "$mainMod, W, togglespecialworkspace, 2, magic"
       "$mainMod, W, movetoworkspace, special:magic"
       "$mainMod, W, togglespecialworkspace, 2, magic"
     ];
     bindm = [
       "$mainMod, mouse:272, movewindow"
       "$mainMod, mouse:273, resizewindow"
     ];
     bindel = [
       ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
       ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
       ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
       ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
       ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
       ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
     ];
     bindl = [
       ", XF86AudioNext, exec, playerctl next"
       ", XF86AudioPause, exec, playerctl play-pause"
       ", XF86AudioPlay, exec, playerctl play-pause"
       ", XF86AudioPrev, exec, playerctl previous"
     ];
     windowrule = [
       "suppressevent maximize, class:.*"
       "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
     ];
   };
 };
}
