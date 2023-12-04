# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  unstable = import
    (builtins.fetchTarball https://github.com/nixos/nixpkgs/archive/nixos-unstable.tar.gz)
    # reuse the current configuration
    { config = config.nixpkgs.config; };
in
{
  imports =
    [ # READ >>>>>> https://github.com/NixOS/nixos-hardware#using-channels <<<<<<
      <nixos-hardware/lenovo/thinkpad/t14/amd/gen1>
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.availableKernelModules = [ "thinkpad_acpi" ];
  boot.initrd.kernelModules = [ "acpi_call" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Stop laptop from sleeping when lid is closed with external power connected
  services.logind.lidSwitchExternalPower = "ignore";

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
    xkbOptions = "caps:escape";
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Control thinkpad fan
  services.thinkfan.enable = true;
  services.thinkfan.levels = [
    [0  0   70]
    [1  68  85]
    ["level auto" 85 32767]
  ];
  #services.thinkfan.sensors = ''
  #  hwmon /sys/devices/platform/thinkpad_hwmon/hwmon/hwmon2/temp1_input
  #'';

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dominik = {
    isNormalUser = true;
    description = "dominik";

    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  home-manager.useGlobalPkgs = true;
  home-manager.users.dominik = { pkgs, ... }: {
    home.stateVersion = "23.05";

    home.packages = [
      pkgs.aws-vault
      pkgs.awscli2
      pkgs.flameshot
      pkgs.gcc
      pkgs.insomnia
      pkgs.kubectl
      pkgs.ruby_3_0
      pkgs.slack
      pkgs.spotify
      pkgs.tig
      pkgs.typos
      pkgs.zoom-us
      unstable.kdocker
      unstable.todoist-electron
    ];

    programs.zsh = {
      enable = true;
      history = {
        path = "/home/dominik/.local/share/zsh/zsh_history";
        ignoreSpace = true;
      };
      sessionVariables = {
        EDITOR="nvim";
        NIXPKGS_ALLOW_INSECURE=1;
        NIXPKGS_ALLOW_UNFREE=1;
        AWS_VAULT_BACKEND="kwallet";
        FZF_DEFAULT_COMMAND=''rg --files --no-ignore --hidden --follow --glob "!.git/*"'';
      };
      initExtra = ''
        setopt HIST_IGNORE_ALL_DUPS
        setopt HIST_IGNORE_SPACE
        setopt HIST_REDUCE_BLANKS
        setopt HIST_SAVE_NO_DUPS
      '';
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "robbyrussell";
      };
    };

    programs.wezterm = {
      enable = true;
      extraConfig = ''
        local copy_mode = nil
        if wezterm.gui then
          copy_mode = wezterm.gui.default_key_tables().copy_mode
          table.insert(
            copy_mode,
            { key = 'Enter', mods = 'NONE', action = wezterm.action.Multiple { { CopyTo = 'ClipboardAndPrimarySelection' }, { CopyMode = 'Close' }, }, }
          )
        end

        return {
          scrollback_lines = 10000,
          harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
          hide_tab_bar_if_only_one_tab = true,
          tab_bar_at_bottom = true,
          leader = { key="b", mods="CTRL", timeout_milliseconds = 2000 },
          keys = {
            { key = "b", mods = "LEADER|CTRL",  action=wezterm.action{SendString="\x01"}},
            { key = "c", mods = "LEADER",       action=wezterm.action{SpawnCommandInNewTab={cwd=wezterm.home_dir}}},
            { key = "n", mods = 'LEADER',       action=wezterm.action{ActivateTabRelative=1}},
            { key = "p", mods = 'LEADER',       action=wezterm.action{ActivateTabRelative=-1}},
            { key = "%", mods = "LEADER|SHIFT", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
            { key = '"', mods = "LEADER|SHIFT", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
            { key = "h", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Left"}},
            { key = "j", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Down"}},
            { key = "k", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Up"}},
            { key = "l", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Right"}},
            { key = "1", mods = "LEADER",       action=wezterm.action{ActivateTab=0}},
            { key = "2", mods = "LEADER",       action=wezterm.action{ActivateTab=1}},
            { key = "3", mods = "LEADER",       action=wezterm.action{ActivateTab=2}},
            { key = "4", mods = "LEADER",       action=wezterm.action{ActivateTab=3}},
            { key = "5", mods = "LEADER",       action=wezterm.action{ActivateTab=4}},
            { key = "6", mods = "LEADER",       action=wezterm.action{ActivateTab=5}},
            { key = "7", mods = "LEADER",       action=wezterm.action{ActivateTab=6}},
            { key = "8", mods = "LEADER",       action=wezterm.action{ActivateTab=7}},
            { key = "9", mods = "LEADER",       action=wezterm.action{ActivateTab=8}},
            { key = "&", mods = "LEADER|SHIFT", action=wezterm.action{CloseCurrentTab={confirm=false}}},
            { key = "u", mods = "LEADER|CTRL",  action=wezterm.action{ScrollByPage=-1}},
            { key = "d", mods = "LEADER|CTRL",  action=wezterm.action{ScrollByPage=1}},
          },
          key_tables = {
            copy_mode = copy_mode,
          }
        }
      '';
    };

    programs.git = {
      enable = true;
      userName  = "Dominik Reller";
      userEmail = "Dom-R@users.noreply.github.com";
      aliases = {
        co = "checkout";
        br = "branch";
        ci = "commit";
        st = "status";
        lol = "for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'";
      };
      attributes = [
        "*.rb diff=ruby"
      ];
      extraConfig = {
        core.editor = "nvim";
        commit.template = "~/.dotfiles/gitmessage";
        push.autoSetupRemote = true;
      };
      difftastic = {
        enable = true;
      };
    };

    programs.firefox.enable = true;

    # jump
    programs.zoxide.enable = true;
  };

  # TODO: Add fallback fonts
  # https://dev.to/moniquelive/using-nerd-font-symbols-and-emoji-with-any-unpatched-font-in-linux-3kdo
  fonts.fontconfig = {
    enable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable the new command-line tool
  nix.settings.experimental-features = [ "nix-command" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    docker
    docker-compose
    fd
    fzf
    git
    gnumake
    jq
    libsForQt5.kalk
    ripgrep
    thinkfan
    unstable.neovim
    wget
    xclip
  ];

  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # Set default editor to neovim
  environment.variables.EDITOR = "nvim";

  programs.zsh.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
