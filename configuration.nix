{ inputs, config, lib, pkgs, ... }:

{
  imports =
    [
      ./Modules/hardware-configuration.nix #You probably want YOUR hardware-configuration.nix and not MINE. Name shouldn't change so you should be ok to leave this as is.
      ./Modules/packages.nix #You want to read through this and add the packages you need and remove the ones you don't
      inputs.home-manager.nixosModules.home-manager #This is home-manager
    ];

   nix.settings.auto-optimise-store = true;

   # This deletes your 10 days or older generations every week. Change this to your liking or delte the paragraph if you don't want this.

   nix.gc = { 
     automatic = true;
     dates = "weekly";
     options = "--delete-older-than 10d";
   };
 
  # Bluetooth, if your system doesn't have or you don't want to use Bluetooth delte this, otherwise uncomment it.
  
  #hardware.bluetooth = {
  #  enable = true;
  #  powerOnBoot = false;
  #};
  #services.blueman.enable = true;

  # Home-manager

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      Nuuvv = import ./Modules/home-manager/home.nix;
    };
  };

  # Use the systemd-boot EFI boot loader. Uncomment the following lines if you want the systemd bootloader, Otherwise delte it. Keep in mind both boot options are for UEFI systems, if your system is not UEFI please refer to the wiki for your bootloader config.
  
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;
  
  # Use GRUB as your bootloader. This is for UEFI systems if your system isn't please refer to the wiki
  
  boot.loader = {
    systemd-boot.enable = false;
    grub = {
      enable = true;
      useOSProber = true;
      device = "nodev";
      efiSupport = true;
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };

  networking.hostName = "Your-happy-computer"; # Define your hostname. This is basically your computer's name, not your user's, call this whatever you would like :).

  #Network Manager, this manages your internet connection. This is for Wired internet, if you want to use wifi you need some extra stuff which is not in this config, refer to the wiki.
  
  networking.networkmanager.enable = true;

  #Player controller, This is a media controller needed for waybar modules and for your pause, play, next, prev media keys in your keyboard to work.
  
  services.playerctld.enable = true;

  # Timezone, Go here https://en.wikipedia.org/wiki/List_of_tz_database_time_zones look for the closest timezone or your timezone and paste it inside the "" below. This will automatically set your clock.
  
  time.timeZone = "Your-timezone-here";

  # Select internationalisation properties. Here is where you tell the computer what kind of characters and keyboard you will be using, this is set for a regular american keyboar and roman letters. Refer to the wiki if you need to alter it to suit your needs.
 
   i18n.defaultLocale = "en_US.UTF-8";
   console = {
     font = "Lat2-Terminus16";
     useXkbConfig = true; # use xkb.options in tty.
   };

  # Enabling hyprland and Wayland. Hyprland is the compositor and window manager we will be using. If you want to use a different WM several parts of this config might not work and you might be better off starting with a default config at that point.
  
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
     };
 environment.sessionVariables = {
    #in case cursor becomes invisible
   WLR_NO_HARDWARE_CURSORS = "1";
    #hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
  };

  #enable Opengl 
  
  hardware.graphics = {
    enable = true;
  };
  
  # Load nvidia drivers for Wayland, This will load your drivers, if you have a 20 series Nvidia GPU or older you don't need to touch this, if you have an older card set the open option to false. If you have ANY other brand of GPU other than nvidia pelase delet this part and refer to the wiki to load your video drivers.
  
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
      modesetting.enable = true;
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Enable sound
    services.pipewire = {
      enable = true;
      pulse.enable =true;
    };

  # Define a user account, This is your User. please edit this and call it whatever you want

   users.users.YourCuteAssName = {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [ #here you can add pkgs for your specific user, tree is added here as an example but most packages in this config are installed system wide in one of the modules.
       tree
     ];
   };
  
  #This is needed for certain things like Nvidia drivers, discord, etc. If you know you don't need this delete it or set it to false. If you get an error saying something about unfree packages then you need to set this to true to use the packages you have declared.

  nixpkgs.config.allowUnfree = true;

  # Steam. If you don't need steam feel free to delete this.
  
   programs.steam = {
     enable = true;
     remotePlay.openFirewall = true; #open ports for remote play
     dedicatedServer.openFirewall = true; #open ports for source deidacated server
     localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network game transfers
   };

   hardware.steam-hardware.enable = true;
   hardware.xone.enable = true; # This is to make Xbox one wireless controller Dongles work on your computer, if you don't need this feel free to delete this line.

   xdg.portal = {
     enable = true;
     extraPortals = with pkgs; [xdg-desktop-portal-gtk];
     config = {
       common.default = ["gtk"];
     };
   };

  # Fonts. Add any fonts you need here. Search for them in search.nixos.org

   fonts.packages = with pkgs; [
     nerd-fonts.noto
     font-awesome
     powerline-fonts
     powerline-symbols
     noto-fonts
     noto-fonts-cjk-sans
     noto-fonts-emoji
     liberation_ttf
     fira-code
     fira-code-symbols
     nerd-fonts.jetbrains-mono
     material-design-icons
   ];

  # This enables Flakes which are necesary for this config, so you don't need to touch this.

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This is your starting system version, your own configuration.nix had this on it and you should copy it over here and never touch it again :)

  system.stateVersion = "25.05"; 

}

