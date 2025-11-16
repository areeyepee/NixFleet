{
  pkgs,
  ...
}:
{
  # ============================================================================
  # IMPORTS
  # ============================================================================

  imports = [
    ../modules/monitoring/node-exporter.nix
  ];
  # ============================================================================
  # NIX CONFIGURATION
  # ============================================================================

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      trusted-users = [ "@wheel" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  nixpkgs.config.allowUnfree = true;

  #Ensures that the nixpgs Path is the same as the one in the Flake.
  #Used for the configuration of nixd (LSP)
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
  # ============================================================================
  # USER MANAGEMENT
  # ============================================================================

  users.users.areeyepee = {
    isNormalUser = true;
    description = "Raphael Pertler";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMzLokg14/USYIlrHwqWavA3DVPiLk+l9PlqwSi3l8Pa logan@franklin"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMIbDuE4vTiYGyYtNXuBGU/Duu5yQqKuH3MwcMDIbavx raphaelpertlerdse@gmail.com" #Desktop-0001
    ];
  };

  # ============================================================================
  # SECURITY
  # ============================================================================

  security.sudo.wheelNeedsPassword = false;

  # ============================================================================
  # NETWORKING
  # ============================================================================

  networking.networkmanager.enable = true;
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];  # SSH

  # ============================================================================
  # SERVICES
  # ============================================================================

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
    };
  };

  # --------------------------------------------------------------------------
  # MONITORING
  # --------------------------------------------------------------------------

  fleet.monitoring.nodeExporter.enable = true;

  # ============================================================================
  # PACKAGES
  # ============================================================================

  environment.systemPackages = with pkgs; [
    neovim
    git
    wget

    alejandra
    nixd

    tlrc

    jujutsu
    lazyjj
  ];


  # ============================================================================
  # PROGRAMS
  # ============================================================================
  programs = {

          ssh.startAgent = true; # Start the ssh-agent automatically

    fish = {
      enable = true;
      shellAliases = {
        ez = "eza --color=always --group-directories-first --icons=always";
        ezl = "eza --long --header --tree --level=2 --all --group-directories-first --no-user --no-permissions --no-time";
      };
    };

    nh = {
      enable = true;

      #flake = "/home/raphael/NIX/NIXOS/NixLaptop/"; String to the default Flake that nh should use for (e.g nh os switch flake)

      clean = {
        enable = true;

        extraArgs = "--keep 5 --keep-since 14d";
      };
    };

    zoxide = {
      enable = true;

      enableFishIntegration = true;
    };

    fzf = {
      fuzzyCompletion = true;
    };

    yazi = {
      enable = true;
    };

    bat = {
      enable = true;

      extraPackages = with pkgs.bat-extras; [core];
    };

    git = {
      enable = true;

      config = {
        user.name = "areeyepee";

        user.email = "rpServer@proton.me";

        init.defaultBranch = "main";
      };
    };

    lazygit = {
      enable = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableFishIntegration = true;
    };
  };

  };





  # ============================================================================
  # LOCALIZATION & TIMEZONE
  # ============================================================================

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # ============================================================================
  # INPUT & KEYBOARD
  # ============================================================================

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
