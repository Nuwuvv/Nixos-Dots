{ pkgs, config, ... }:
#Here you install your packages, search for whatever you want in seach.nixos.org and type it's name on this list, whatever is on the list will be installed, whatever isn't will be uninstalled.
{
 environment.systemPackages = with pkgs; [
   waybar #Your system bar, if you want my bar don't delte this
   fastfetch #A cool looking fetcher, in this config it is preconfigured in fastfetch.nix with a gif of best girl REM, but feel free to change it to your liking.
   kitty #This is your terminal
   libnotify #This is a notifications daemon, so you can get notifications
   hyprpaper #This sets your wallpapers.
   brave #This is your web browser.
   wget
   btop #This is a system resource manager.
   nnn #This is a terminal file explorer, if you want something easier use Dolphin, but I recommend learning this instead, it's really nice :)
   linuxKernel.packages.linux_zen.xone #This is for xbox one wireless dongle, feel free to delete this line if you are not going to use one.
   grim
   slurp #This and grim are for taking screenshots.
   cava #Cool terminal bar display for music.
   nvtopPackages.nvidia #This is like btop but for your Nvidia GPU.
   usbutils #This is for USB drives.
   home-manager 
   git
   wttrbar #This is for the weather module on your system bar.
   nvd #This is for the update  module on your system bar.
   spotify
   nh
   ffmpeg #This is needed for fastfetch.
 ];
}
