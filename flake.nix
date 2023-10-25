{
  description = "nbdy-cntrl's Flake!";

  inputs = 
  {
    nixpkgs = 
    {
      url = "nixpkgs/nixos-23.05";
    };
  };

  outputs = { self, nixpkgs, ... }:
    let
      #   _____           _                 
      #  /  ___|         | |                
      #  \ `--. _   _ ___| |_ ___ _ __ ___  
      #   `--. \ | | / __| __/ _ \ '_ ` _ \ 
      #  /\__/ / |_| \__ \ ||  __/ | | | | |
      #  \____/ \__, |___/\__\___|_| |_| |_|
      #          __/ |                      
      #         |___/                       
      system = "x86_64-linux"; # system arch
      hostname = "chernobyl"; # hostname
      version = "desktop"; # vm, desktop, laptop
      timezone = "America/Vancouver"; # select timezone
      locale = "en_CA.UTF-8"; # select locale
      nixVersion = "23.05";

      #   _   _               
      #  | | | |              
      #  | | | |___  ___ _ __ 
      #  | | | / __|/ _ \ '__|
      #  | |_| \__ \  __/ |   
      #   \___/|___/\___|_|   
      #                       
      username = "nbdy"; # username
      name = "nbdy"; # name/identifier
      dm = "gdm"; # gdm, lightdm
      wm = "gnome"; # gnome, hyprland

      #
      # configure lib
      #
      lib = nixpkgs.lib;
    in
  {
    nixosConfigurations = 
    {
      chernobyl = lib.nixosSystem {
        system = "x86_64-linux";

        modules = [ (./. + "/versions" + ("/" + version) + "/configuration.nix") ];

        specialArgs =
        {
            inherit system;
            inherit hostname;
            inherit timezone;
            inherit locale;
            inherit nixVersion;

            inherit username;
            inherit name;
            inherit dm;
            inherit wm;
        };
      };
    };
  };
}
