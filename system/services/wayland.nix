{ config, pkgs, ... }:

{
  programs.xwayland.enable = true;

  services.xserver = 
  {
    enable = true;

    videoDrivers = ["nvidia"];

    layout = "us";
    xkbVariant = "";
  };
}