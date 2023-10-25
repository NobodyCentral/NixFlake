{ config, pkgs, ... }:

{
  services.xserver = 
  {
    enable = true;
    
    videoDrivers = ["nvidia"];

    layout = "us";
    xkbVariant = "";
  };
}