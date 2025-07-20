{ inputs, config, pkgs, ... }:
{
 services.dunst = {
   enable = true;
   settings = {
     global = {
       monitor = "DP-5"; #This defines on what monitor you want your notifications to show up, if you only have one then you can delte this line, otherwise use xrandr to figure out your main monitor name and put that in instead. To install xrand use a nix shell with the nix-shell -p xrandr command.
       offset = "20x10";
       progress_bar = true;
       progress_bar_height = 10;
       progress_bar_max_width = 350;
       progress_bar_min_width = 0;
       progress_bar_corner_radius = 6;
       highlight = "#cdd6f4"; 
       icon_corner_radius = 6;
       corner_radius = 6;
       background = "#46526499";
       foreground = "#cdd6f4";
       frame_color = "#cdd6f4";
       width = 350;
       height = 150;
     };
   };
 };
}
