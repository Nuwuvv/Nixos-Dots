{
  description = " Nuuvv's config flake ☆*:.｡.o(≧▽≦)o.｡.:*☆ ";

  #This is the flake config, you don't need to touch flake.lock ever, so don't worry about that. A flake just manages package versions and if you don't care about that there isn't a lot to change here, still read through it and change what little needs to be changed.

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # I like to use the unstable branch, change it to stable if you wish, to do that please refer to the Maual/wiki.
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs =
    { self, nixpkgs, home-manager, stylix,  ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in
    {
      homeConfigurations."your.username.here" = home-manager.lib.homeManagerConfiguration { # Here you want to type the user name you set on configuration.nix
        inherit pkgs;
        modules = [ 
          ./Modules/home-manager/home.nix 
          inputs.stylix.homeModules.stylix
        ];
      };
      nixosConfigurations = {
       "Your.Host.Computer.Name.Here" = nixpkgs.lib.nixosSystem { #HERE you should put your host's name. If you don't whenever you type sudo nixos-rebuild switch --flake . it won't work and you will have to specify #whatever you type here at the end, which is a pain in the ass, so just put your hostname here.
          specialArgs = { inherit inputs system; };
          modules = [
          ./configuration.nix
          ];
        };
      };
    };
}
