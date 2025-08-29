{ inputs, config, pkgs, ... }:

{
 home.username = "Your.Username"; #Type your Username in there again.
 home.homeDirectory = "/home/Your.Username"; #And here too xd.
 imports = [ #This imports all our modules for home manager.
   ./hyprland.nix
   ./hyprpaper.nix
   ./kitty.nix
   ./stylix.nix
   inputs.stylix.homeModules.stylix
   ./waybar.nix
   ./waybar-style.nix
   ./nvim.nix
   ./rofi.nix
   ./dunst.nix
   ./fastfetch.nix
   ./hypridle.nix
   ./hyprlock.nix
 ];

 # Don't touch
 home.stateVersion = "25.05"; #Same as on configuration.nix, you should put here whatever your original home.nix said and never touch it again.

 home.packages = with pkgs; [ #in case you want to install packages with home manager,those go here.
 ];

 home.file = {

 };

 home.sessionVariables = { #to make NeoVim your default text editor.
   EDITOR = "nvim";
 };

 programs.home-manager.enable = true;
}
