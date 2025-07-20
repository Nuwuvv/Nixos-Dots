{ config, pkgs, ... }:
{
 programs.waybar.style = ''
    * {
      border: none;
      border-radius: 0px;
      font-family: JetBrainsMono Nerd Fonts;
      font-size: 14px;
      font-style: normal;
      font-weight: normal;
      min-height: 0px;
      padding: 0px;
      margin: 0px;
    }
    
    tooltip {
      background-color: rgba(46,52,64,0.3);
      color: #f38986;
      border-radius: 16px;
      margin: 5px;
      padding: 0px 10px 0px 10px;
      font-weight: bold;
    }

    window#waybar {
      background: transparent;
    }
 
    #custom-launcher {
      color: #cdd6f4;
      background-color: rgba(46,52,64,0.6);
      border: solid 2px rgba(205,214,244,0.7);
      border-radius: 8px;
      margin: 5px 5px 5px 5px;
      padding: 0px 15px 1px 9px;
      font-size: 25;
    }

    #workspaces {
      background: rgba(46,52,64,0.6);
      margin: 5px 7px 5px 7px;
      padding: 8px 5px;
      border-radius: 8px;
      border: solid 2px rgba(205,214,244,0.7);
      font-weight: normal;
      font-style: normal;
    }

    #workspaces button {
      padding: 0px 5px;
      margin: 0px 3px;
      border-radius: 16px;
      color: #d8dee9;
      background-color: #6f7787;
      transition: all 0.3s ease-in-out;
    }

    #workspaces button:hover {
      background-color: #cdd6f4;
      color: #cdd6f4;
      border-radius: 14px;
      min-width: 40px;
      background-size: 400% 400%;
    }

    #workspaces button.active {
      background-color: #cdd6f4;
      color: #cdd6f4;
      border-radius: 14px;
      min-width: 40px;
      background-size: 400% 400%;
      transition: all 0.3s ease-in-out;
      border: 0px solid rgba(0, 0, 0, 0);
    }

    #cava {
      /*color: #cdd6f4;*/
      background-color: rgba(46,52,64,0.6);
      border-radius: 8px;
      padding: 0px 10px 0px 10px;
      margin: 5px 7px 5px 7px;
      border: solid 2px rgba(205,214,244,0.7);
      font-weight: bold;
      font-size: 20;
    } 

    #mpris {
      /*color: #f3eedd;*/
      background-color: rgba(46,52,64,0.6);
      border-radius: 8px;
      border: solid 2px rgba(205,214,244,0.7);
      margin: 5px 7px 5px 7px;
      padding: 0px 15px 0px 15px;
      font-size: 16;
    }

    #bluetooth {
      background-color: rgba(46,52,64,0.6);
      color: #3924f3;
      border-radius: 8px;
      border: solid 2px rgba(205,214,244,0.7);
      margin: 6px 7px 6px 7px;
      padding: 0px 10px 0px 10px;
    }

    #tray {
      background: rgba(46,52,64,0.6);
      border-radius: 8px;
      border: solid 2px rgba(205,214,244,0.7);
      padding: 0px 10px 0px 10px;
      margin: 5px 7px 5px 7px;
    }

    #tray menu {
      background-color: rgba(46,52,64,0.5);
      border-radius: 14px;
      border: solid 1px rgba(205,214,244,0.7);
      padding: 5px;
    }

    #window {
      background: rgba(46,52,64,0.6);
      border: solid 2px rgba(205,214,244,0.7);
      padding-left: 15px;
      padding-right: 15px;
      border-radius: 8px;
      margin: 3px 0px 3px 0px;
      font-weight: normal;
      font-style: normal;
      font-size: 16;
    }

    #network {
      background-color: rgba(46,52,64,0.6);
      border: solid 2px rgba(205,214,244,0.7);
      border-radius: 8px;
      margin: 6px 5px 6px 5px;
      padding: 0px 15px 0px 15px;
    }

    #custom-updates {
      background-color: rgba(46,52,64,0.6);
      border: solid 2px rgba(205,214,244,0.7);
      border-radius: 8px;
      margin: 6px 5px 6px 5px;
      padding: 0px 15px 0px 15px;
    }
      
    #disk {
      background-color: rgba(46,52,64,0.6);
      color: #c68cff;
      border-radius: 8px;
      border: solid 2px rgba(205,214,244,0.7);
      margin: 6px 5px 6px 5px;
      padding: 0px 10px 0px 10px;
      font-size: 14;
    }

    #memory {
      background-color: rgba(46,52,64,0.6);
      color: #fff785;
      border-radius: 8px;
      border: solid 2px rgba(205,214,244,0.7);
      margin: 6px 5px 6px 5px;
      padding: 0px 10px 0px 10px;
      font-size: 14;
    }

    #cpu {   
      background-color: rgba(46,52,64,0.6);
      color: #f38986;
      border-radius: 8px;
      border: solid 2px rgba(205,214,244,0.7);
      margin: 6px 5px 6px 5px;
      padding: 0px 10px 0px 10px;
      font-size: 14;
    }

    #pulseaudio {
      color: #5c64f3;
      background: rgba(46,52,64,0.6);
      border-radius: 8px;
      border: solid 2px rgba(205,214,244,0.7);
      margin: 6px 5px 6px 5px;
      padding: 0px 15px 0px 15px;
      font-size: 14;
    }

    #custom-weather {
      background-color: rgba(46,52,64,0.6);
      border-radius: 8px;
      border: solid 2px rgba(205,214,244,0.7);
      padding-left: 17px;
      padding-right: 15px;
      margin: 6px 5px 6px 5px;
      font-size: 16;
    }

    #clock {
      background-color: rgba(46,52,64,0.6);
      border-radius: 8px;
      padding-left: 13px;
      padding-right: 15px;
      margin: 6px 5px 6px 5px;
      border: solid 2px rgba(205,214,244,0.7);
      font-size: 14;
    }


  '';
}

