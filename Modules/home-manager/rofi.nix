{ config, pkgs, ... }:
{
 programs.rofi = {
   enable = true;
   font = "JetBrains Mono Nerd Font 10";
   modes = [ "drun" "run" ];
   package = pkgs.rofi-wayland;
   theme = 
     let
       inherit (config.lib.formats.rasi) mkLiteral;
     in {
       
       "#configuration" = {
         show-icons = true;
         drun-display-format = "{name}";
         hover-select = true;
       };

       "*" = {
         background-color = mkLiteral "transparent";
         text-color = mkLiteral "#c9eafd";
       };

       "#window" = {
         location = mkLiteral "center";
         anchor = mkLiteral "center";
         border = mkLiteral "1px";
         border-radius = mkLiteral "30px";
         background-color = mkLiteral "transparent";
         width = mkLiteral "38%";
       };

       "#mainbox" = {
         children = map mkLiteral [ "img" "listbox" ];
         orientation = mkLiteral "horizontal";
         background-color = mkLiteral "transparent";
         spacing = mkLiteral "24px";
       };

       "#listbox" = {
         spacing = mkLiteral "20px";
         background-color = mkLiteral "transparent";
         orientation = mkLiteral "vertical";
         children = map mkLiteral [ "inputbar" "message" "listview" ];
       };

       "#listview" = {
         background-color = mkLiteral "#03294099";
         text-color = mkLiteral "#c9eafd";
         border-radius = mkLiteral "30px";
         columns = mkLiteral "2";
         lines = mkLiteral "6";
         cycle = true;
         dynamic = true;
         scrollbar = false;
         layout = mkLiteral "vertical";
         reverse = false;
         fixed-height = true;
         fixed-columns = true;
       };

       "#img" = {
         padding = mkLiteral "64px 200px";
         border-radius = mkLiteral "24px";
         background-image = mkLiteral "url(\"~/.config/Nixos/Modules/home-manager/Wallpapers/fantasy-house-painting-ultrawide.png\", height)";
       };

       "#inputbar" = {
         children = map mkLiteral [ "textbox-icon" "entry" ];
         border-radius = mkLiteral "12px";
         background-color = mkLiteral "#03294099";
         spacing = mkLiteral "0px";
         margin = mkLiteral "0px";
         padding = mkLiteral "14px";
       };

       "#textbox-icon" = {
         expand = false;
         background-color = mkLiteral "transparent";
         text-color = mkLiteral "#c9eafd";
         str = "  ";
       };

       "#entry" = {
         cursor = mkLiteral "text";
         expand = false;
         placeholder-color = mkLiteral "inherit";
         placeholder = "Search";
         background-color = mkLiteral "transparent";
         text-color = mkLiteral "#c9eafd";
       };

       "#element" = {
         background-color = mkLiteral "transparent";
         border-radius = mkLiteral "10px";
         padding = mkLiteral "12px";
       };

       "element-text" = {
         background-color = mkLiteral "transparent";
         text-color = mkLiteral "inherit";
         vertical-align = mkLiteral "0.5";
         horizontal-align = mkLiteral "0.0";
       };
   };
 };
}
