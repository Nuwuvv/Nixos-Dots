{ inputs, config, pkgs, ... }:
{
  programs = {
    fastfetch = {
      enable = true;
      settings = {
        logo = {
          source = "/home/Nuuvv/.config/Nixos/Modules/home-manager/rem-smile.gif";
          type = "kitty-icat";
        };
        modules = [
          "title"
          "separator"
          "os"
          "kernel"
          "shell"
          "wm"
          "terminal"
          "cpu"
          "gpu"
          "memory"
          "disk"
          "colors"
        ];
      };
    };
  };
}  
