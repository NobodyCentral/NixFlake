{ config, pkgs, ... }:

{
  imports = 
  [
    ../services/x11.nix
    ../services/pipewire.nix
    ../services/dbus.nix
  ];

  services.xserver = 
  {
    desktopManager = 
    {
      gnome.enable = true;
    };

    displayManager = 
    {
      defaultSession = "gnome";
    };
  };
}