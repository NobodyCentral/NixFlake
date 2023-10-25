{ config, lib, pkgs, ... }:

{
  imports = 
  [
    ../services/wayland.nix
    ../services/pipewire.nix
    ../services/dbus.nix
    ../services/xdg.nix
  ];

  programs.hyprland = 
  {
    enable = true;
    
    nvidiaPatches = true;
    xwayland.enable = true;
  };

  services.xserver = 
  {
    displayManager = 
    {
      defaultSession = "hyprland";
    };
  };

  environment.sessionVariables = 
  {
    WLR_NO_HARDWARE_CURSORS = "1";

    NIXOS_OZONE_WL = "1";
  };

  xdg.portal.extraPortals = 
  [
    pkgs.xdg-desktop-portal-hyprland
  ];

  environment.systemPackages = with pkgs;
  [
    (pkgs.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      })
    )

    kitty
    waybar
    dunst
  ];
}