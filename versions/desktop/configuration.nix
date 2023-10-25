{ config, pkgs, system, hostname, timezone, locale, nixVersion, username, name, dm, wm, ... }:

{
  #   _____           _                 
  #  /  ___|         | |                
  #  \ `--. _   _ ___| |_ ___ _ __ ___  
  #   `--. \ | | / __| __/ _ \ '_ ` _ \ 
  #  /\__/ / |_| \__ \ ||  __/ | | | | |
  #  \____/ \__, |___/\__\___|_| |_| |_|
  #          __/ |                      
  #         |___/                       
  imports =
  [
    ../../hardware-configuration.nix

    ../../system/hardware/kernel.nix
    ../../system/hardware/power.nix
    ../../system/hardware/opengl.nix
    ../../system/hardware/bluetooth.nix

    ../../system/security/firewall.nix
    ../../system/security/polkit.nix

    (./. + "../../../system/display-manager" + ("/" + dm) + ".nix")
    (./. + "../../../system/window-manager" + ("/" + wm) + ".nix")
  ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs;
  [
    vim
    wget
    git
  ];

  system.stateVersion = nixVersion;

  nix.settings.experimental-features = 
  [
    "nix-command"
    "flakes"
  ];

  #  ______             _   _                 _           
  #  | ___ \           | | | |               | |          
  #  | |_/ / ___   ___ | |_| | ___   __ _  __| | ___ _ __ 
  #  | ___ \/ _ \ / _ \| __| |/ _ \ / _` |/ _` |/ _ \ '__|
  #  | |_/ / (_) | (_) | |_| | (_) | (_| | (_| |  __/ |   
  #  \____/ \___/ \___/ \__|_|\___/ \__,_|\__,_|\___|_|   
  #                                                       
  boot.loader = 
  {
    efi = 
    {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };

    systemd-boot.enable = false;

    grub = 
    {
      enable = true;
      device = "nodev";

      efiSupport = true;
      useOSProber = true;

      configurationLimit = 5;
    };

    timeout = 10;
  };

  #   _   _      _                      _    _             
  #  | \ | |    | |                    | |  (_)            
  #  |  \| | ___| |___      _____  _ __| | ___ _ __   __ _ 
  #  | . ` |/ _ \ __\ \ /\ / / _ \| '__| |/ / | '_ \ / _` |
  #  | |\  |  __/ |_ \ V  V / (_) | |  |   <| | | | | (_| |
  #  \_| \_/\___|\__| \_/\_/ \___/|_|  |_|\_\_|_| |_|\__, |
  #                                                   __/ |
  #                                                  |___/ 
  networking = 
  {
    hostName = hostname;

    networkmanager = 
    {
      enable = true;
    };
  };

  #   _                     _           
  #  | |                   | |          
  #  | |     ___   ___ __ _| | ___  ___ 
  #  | |    / _ \ / __/ _` | |/ _ \/ __|
  #  | |___| (_) | (_| (_| | |  __/\__ \
  #  \_____/\___/ \___\__,_|_|\___||___/
  #                                     
  time.timeZone = timezone;

  i18n.defaultLocale = locale;

  #   _   _               
  #  | | | |              
  #  | | | |___  ___ _ __ 
  #  | | | / __|/ _ \ '__|
  #  | |_| \__ \  __/ |   
  #   \___/|___/\___|_|   
  #                       
  users.users.${username} = 
  {
    isNormalUser = true;
    description = name;
    extraGroups = 
    [
      "networkmanager"
      "wheel" 
    ];
    packages = with pkgs;
    [
      firefox
    ];
  };
}
