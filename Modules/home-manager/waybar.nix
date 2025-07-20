{ config, pkgs, ... }:
let
  toggleSinks-sh = pkgs.pkgs.writeShellScriptBin "ToggleSinks" ''
    # Add sink names (separated with '|') to SKIP while switching with this script. Choose names to skip from the output of this command:
    # wpctl status -n | grep -zoP '(?<=Sinks:)(?s).*?(?=├─)' | grep -a "vol:"
    # if no skip names are added, this script will switch between every available audio sink (output).
    SINKS_TO_SKIP=("alsa_output.pci-0000_01_00.1.hdmi-stereo")

    #Define Aliases (OPTIONAL)
    #ALIASES="sink_name1:Scarlett 4i4 4th Gen Analog Surround 2.1\nsink_name2:G560 Gaming Speaker Analog Surround 2.1"

    #Create array of sink names to switch to
    declare -a SINKS_TO_SWITCH=(''$(wpctl status -n | grep -zoP '(?<=Sinks:)(?s).*?(?=├─)' | grep -a "vol:" | tr -d \* | awk '{print (''$3)}' | grep -Ev ''$SINKS_TO_SKIP))
    SINK_ELEMENTS=''$(echo ''${#SINKS_TO_SWITCH[@]})

    #Get current sink name and array position
    ACTIVE_SINK_NAME=''$(wpctl status -n | grep -zoP '(?<=Sinks:)(?s).*?(?=├─)' | grep -a '*' | awk '{print (''$4)}')
    ACTIVE_ARRAY_INDEX=''$(echo ''${SINKS_TO_SWITCH[@]/''$ACTIVE_SINK_NAME//} | cut -d/ -f1 | wc -w | tr -d ' ')

    #Get next array name and then its ID to switch to
    NEXT_ARRAY_INDEX=''$(((''$ACTIVE_ARRAY_INDEX+1)%''$SINK_ELEMENTS))
    NEXT_SINK_NAME=''${SINKS_TO_SWITCH[''$NEXT_ARRAY_INDEX]}
    NEXT_SINK_ID=''$(wpctl status -n | grep -zoP '(?<=Sinks:)(?s).*?(?=├─)' | grep -a ''$NEXT_SINK_NAME | awk '{print (''$2+0)}')

    #Switch to sink & notify
    wpctl set-default ''$NEXT_SINK_ID
    out=''$(gdbus call --session \
      --dest org.freedesktop.Notifications \
      --object-path /org/freedesktop/Notifications \
      --method org.freedesktop.Notifications.CloseNotification \
      "''$(cat /tmp/sss.id 2>/dev/null)" 2>/dev/null)
    ALIAS=''$(echo -e ''$ALIASES | grep ''$NEXT_SINK_NAME | awk -F ':' '{print (''$2)}')
    out=''$(gdbus call --session \
      --dest org.freedesktop.Notifications \
      --object-path /org/freedesktop/Notifications \
      --method org.freedesktop.Notifications.Notify sss \
      0 \
      gtk-dialog-info "Sound Sink Switcher" "Switching to ''$NEXT_SINK_ID : ''$NEXT_SINK_NAME (''$ALIAS)" [] {} 5000 | \
      sed 's/(uint32 \([0-9]\+\),)/\1/g' > /tmp/sss.id)
  '';
     
in  
{
 imports = [
   ./updates-waybar.nix
 ];
 programs.waybar = {
   enable = true;
   settings = {
     mainBar = {
      position = "top";
       layer = "top";
       height = 25;
       modules-left = [ "custom/launcher" "hyprland/workspaces" "cava" "mpris" "bluetooth" "tray" ];
       modules-center = [ "hyprland/window" ];
       modules-right = [ "network" "custom/updates" "disk" "memory" "cpu" "pulseaudio" "custom/weather" "clock" ];
 
       "custom/launcher" = {
         format = "󱄅";
         on-click = "grim -o DP-5";
         on-click-right = "grim -g \"$(slurp)\"";
       };
 
       "hyprland/workspaces" = {
         active-only = false;
         all-outputs = true;
         disable-scroll = false;
         on-scroll-up = "hyprctl dispatch workspace e-1";
         on-scroll-down = "hyprctl dispatch workspace e+1";
         format = "{icon}";
         on-click = "activate";
         format-icons = {
           urgent = "";
           active = "";
           default = "";
         };
         sort-by-number = true;
       };

       "cava" = {
         framerate = 30;
         autosens = 1;
         sensitivity = 1;
         bars = 14;
         lower_cutoff_freq = 50;
         higher_cutoff_freq = 10000;
         method = "pulse";
         source = "auto";
         stereo = true;
         reverse = false;
         bar_delimiter = 0;
         monstercat = false;
         waves = false;
         noise_reduction = 0.77;
         input_delay = 2;
         format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
         actions = {
           on-click-right = "mode";
         };
       };

       "mpris" = {
         format = "{player_icon}  {status_icon}  {title} - {artist}";
         format-paused = "{player_icon}  {status_icon}  {title} - {artist}";
         max-length = 35;
         on-scroll-up = "playerctld shift";
         on-scroll-down = "playerctld shift";
         player-icons = {
           default = "󰎈";
           mpv = "";
           vlc = "<span color='#E85E00'>󰕼</span>";
           spotify = "<span size='13000' color='#1DB954'></span>";
           brave = "<span font='normal Font Awesome 6 Free' color='#ed7009'></span>";
         };
         status-icons = {
           paused = "";
           playing = "⏸";
           stopped = "";
         };
       };

       "bluetooth" = {
         format-on = "<span size='14000'>󰂯</span>";
         format-off = "<span size='14000' foreground='#f37061'>󰂲</span>";
         on-click = "bluetoothctl power on";
         on-click-right = "bluetoothctl power off";
       };

       "tray" = {
         icon-size = 21;
         spacing = 10;
       };

       "hyprland/window" = {
         format = "{}";
         max-length = 45;
         rewrite = {
           "(.*) - Brave" = "<span font='normal Font Awesome 6 Free' color='#ed7009'></span>  $1";
           "(.*) - Discord" = "<span color='#5378f3'></span> $1";
         };
         separate-outputs = true;
       };

       "network" =  {
         format = "{bandwidthDownBits}  <span size='13000' foreground='#61f38d'>󰁈</span>  | {bandwidthUpBits}  <span size='13000' foreground='#f37e8a'>󰁠</span>";
         interval = 1;
       };

       "disk" = {
         format = "   {}%";
         format-alt = "   {used}/{total} GiB";
         interval = 20;
         path = "/";
       };

       "memory" = {
         format = "  {}%";
         format-alt = "  {used}/{total} GiB";
         interval = 5;
       };

       "cpu" = {
         format = "󰍛   {usage}%";
         format-alt = "󰍛   {avg_frequency} GHz";
         interval = 5;
       };

       "pulseaudio" = {
         format = "<span size='15000'>{icon}</span>  {volume}%";
         format-muted = "<span size='15000' foreground='#f37061'>󰝟</span>  {volume}%";
         format-icons = {
           headphone = " ";
           hands-free = "";
           headset = " ";
           phone = "";
           portable = "";
           car = "";
           default = ["󰕿" "󰖀" "󰕾"];
         };
         on-click = "wpctl set-mute @DEFAULT_SINK@ toggle";
         on-click-right = ''${toggleSinks-sh}/bin/ToggleSinks'';
         on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+";
         on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-";
       };

        "custom/weather" = {
         format = "{}°";
         tooltip = true;
         interval = 600;
         exec = ''wttrbar --nerd --custom-indicator "{ICON}   {temp_C}"'';
         return-type = "json";
       }; 

       "clock" = {
         interval = 1;
         format = " {:%a  %B %d    %H:%M}";
         format-alt = "  {:%H:%M}";
         tooltip-format = "<tt>{calendar}</tt>";
         calendar = {
           mode-mon-col = 3;
           format = {
             months = "<span color='#f3f3f3'><b>{}</b></span>";
             weekdays = "<span color='#9e79f3'><b>{}</b></span>";
             today = "<span color='#f36849'><b><u>{}</u></b></span>";
             days = "<span size='10pt' color='#f3f3f3'><b>{}</b></span>";
           };
         };
       };
     };

    verticalMonitorBar = {
       output = [
         "DP-6"
       ];
       position = "top";
       layer = "top";
       height = 14;
       modules-left = [ "custom/launcher" "hyprland/workspaces" "tray" ];
       modules-center = [ "hyprland/window" ];
       modules-right = [ "pulseaudio" "clock" ];
 
       "custom/launcher" = {
         format = "󱄅";
         on-click = "grim -o DP-5";
         on-click-right = "grim -g \"$(slurp)\"";
       };

       "hyprland/workspaces" = {
         active-only = false;
         all-outputs = true;
         disable-scroll = false;
         on-scroll-up = "hyprctl dispatch workspace e-1";
         on-scroll-down = "hyprctl dispatch workspace e+1";
         format = "{icon}";
         on-click = "activate";
         format-icons = {
           urgent = "";
           active = "";
           default = "";
         };
         sort-by-number = true;
       };

       "tray" = {
         icon-size = 21;
         spacing = 10;
       };

       "hyprland/window" = {
         format = "{}";
         max-length = 35;
         rewrite = {
           "(.*) - Brave" = "<span font='normal Font Awesome 6 Free' color='#ed7009'></span> $1";
           "(.*) - kitty" = " $1";
           "(.*) - Discord" = "<span color='#5378f3'></span> $1";
         };
         separate-outputs = true;
       };

       "pulseaudio" = {
         format = "<span size='15000'>{icon}</span>  {volume}%";
         format-muted = "<span size='15000' foreground='#f37061'>󰝟</span>  {volume}%";
         format-icons = {
           headphone = " ";
           hands-free = "";
           headset = " ";
           phone = "";
           portable = "";
           car = "";
           default = ["󰕿" "󰖀" "󰕾"];
         };
         on-click = "wpctl set-mute @DEFAULT_SINK@ toggle";
         on-click-right = ''${toggleSinks-sh}/bin/ToggleSinks'';
         on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+";
         on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-";
       };

       "clock" = {
         interval = 1;
         format = " {:%a  %B %d    %H:%M}";
         format-alt = "  {:%H:%M}";
         tooltip-format = "<tt>{calendar}</tt>";
         calendar = {
           mode-mon-col = 3;
           format = {
             months = "<span color='#f3f3f3'><b>{}</b></span>";
             weekdays = "<span color='#9e79f3'><b>{}</b></span>";
             today = "<span color='#f36849'><b><u>{}</u></b></span>";
             days = "<span size='10pt' color='#f3f3f3'><b>{}</b></span>";
           };
         };
       };
     };
     "1080pBar" = {
       output = [
         "HDMI-A-2"
       ];
       position = "top";
       layer = "top";
       height = 14;
       modules-left = [ "custom/launcher" "hyprland/workspaces" "mpris" "tray" ];
       modules-center = [ "hyprland/window" ];
       modules-right = [ "pulseaudio" "custom/weather" "clock" ];
 
       "custom/launcher" = {
         format = "󱄅";
         on-click = "grim -o DP-5";
         on-click-right = "grim -g \"$(slurp)\"";
       };
 
       "hyprland/workspaces" = {
         active-only = false;
         all-outputs = true;
         disable-scroll = false;
         on-scroll-up = "hyprctl dispatch workspace e-1";
         on-scroll-down = "hyprctl dispatch workspace e+1";
         format = "{icon}";
         on-click = "activate";
         format-icons = {
           urgent = "";
           active = "";
           default = "";
         };
         sort-by-number = true;
       };

       "mpris" = {
         format = "{player_icon}  {status_icon}  {title} - {artist}";
         format-paused = "{player_icon}  {status_icon}  {title} - {artist}";
         max-length = 30;
         on-scroll-up = "playerctld shift";
         on-scroll-down = "playerctld shift";
         player-icons = {
           default = "󰎈";
           mpv = "";
           vlc = "<span color='#E85E00'>󰕼</span>";
           spotify = "<span color='#1DB954'></span>";
           brave = "<span font='normal Font Awesome 6 Free' color='#ed7009'></span>";
         };
         status-icons = {
           paused = "";
           playing = "⏸";
           stopped = "";
         };
       };

       "tray" = {
         icon-size = 21;
         spacing = 10;
       };

       "hyprland/window" = {
         format = "{}";
         max-length = 40;
         rewrite = {
           "(.*) - Brave" = "<span font='normal Font Awesome 6 Free' color='#ed7009'></span> $1";
           "(.*) - kitty" = " $1";
           "(.*) - Discord" = "<span color='#5378f3'></span> $1";
         };
         separate-outputs = true;
       };

       "pulseaudio" = {
         format = "<span size='15000'>{icon}</span>  {volume}%";
         format-muted = "<span size='15000' foreground='#f37061'>󰝟</span>  {volume}%";
         format-icons = {
           headphone = " ";
           hands-free = "";
           headset = " ";
           phone = "";
           portable = "";
           car = "";
           default = ["󰕿" "󰖀" "󰕾"];
         };
         on-click = "wpctl set-mute @DEFAULT_SINK@ toggle";
         on-click-right = ''${toggleSinks-sh}/bin/ToggleSinks'';
         on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+";
         on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-";
       };

       "clock" = {
         interval = 1;
         format = " {:%a  %B %d    %H:%M}";
         format-alt = "  {:%H:%M}";
         tooltip-format = "<tt>{calendar}</tt>";
         calendar = {
           mode-mon-col = 3;
           format = {
             months = "<span color='#f3f3f3'><b>{}</b></span>";
             weekdays = "<span color='#9e79f3'><b>{}</b></span>";
             today = "<span color='#f36849'><b><u>{}</u></b></span>";
             days = "<span size='10pt' color='#f3f3f3'><b>{}</b></span>";
           };
         };
       };

       "custom/weather" = {
         format = "{}°";
         tooltip = true;
         interval = 600;
         exec = ''wttrbar --nerd --custom-indicator "{ICON}   {temp_C}"'';
         return-type = "json";
       }; 
     };
   };
 };
}
