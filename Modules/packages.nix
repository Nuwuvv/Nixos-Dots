{ pkgs, config, ... }:
#Here you install your packages, search for whatever you want in seach.nixos.org and type it's name on this list, whatever is on the list will be installed, whatever isn't will be uninstalled.
{
 environment.systemPackages = with pkgs; [
   waybar #Your system bar, if you want my bar don't delte this
   neofetch #A cool looking fetcher, it's unmantained, if you don't like this delte this line and install fastfetch if you want.
   kitty #This is your terminal
   libnotify #This is a notifications daemon, so you can get notifications
   hyprpaper #This sets your wallpapers.
   brave #This is your web browser.
   wget
   btop #This is a system resource manager.
   nnn #This is a terminal file explorer, if you want something easier use Dolphin, but I recommend learning this instead, it's really nice :)
   linuxKernel.packages.linux_zen.xone #This is for xbox one wireless dongle, feel free to delete this line if you are not going to use one.
   nvtopPackages.nvidia #This is like btop but for your Nvidia GPU.
   usbutils #This is for USB drives.
   home-manager 
   git
   wttrbar #This is for the weather module on your system bar.
   nvd #This is for the update  module on your system bar.
   spotify-player #This is a terminal spotify player, feel free to replace this for spotify if you want.
 ];
}
