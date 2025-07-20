{ config, pkgs, ... }:
{
 services.hyprpaper = {
   enable = true;
   settings = {
     preload = [
       "~/.config/Nixos/Modules/home-manager/Wallpapers/Positive-duck-happy4k.png"
     ];
     wallpaper = [
       "DP-5, ~/.config/Nixos/Modules/home-manager/Wallpapers/Positive-duck-happy4k.png" #monitor 1
     ];
   };
 };
}
