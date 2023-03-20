{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "dominik";
  home.homeDirectory = "/home/dominik";

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
      ZSH_TMUX_AUTOSTART=true;
      AWS_VAULT_BACKEND="kwallet";
    };
    initExtra = ''
      setopt HIST_IGNORE_ALL_DUPS
      setopt HIST_SAVE_NO_DUPS
    '';
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "tmux" ];
      theme = "robbyrussell";
    };
  };

  programs.alacritty = {
    enable = true;
    #settings.font.normal.family = "iA Writer Quattro V";
    settings = {
      font.size = 16;
      key_bindings = [
        {
          key = "Insert";
          mods = "Control";
          action = "None";
        }
      ];
    };
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
    extraConfig = {
      core.editor = "nvim";
      commit.template = "~/.dotfiles/gitmessage";
      diff.external = "difft";
      push.autoSetupRemote = true;
    };
  };

  programs.tmux = {
    enable = true;
    historyLimit = 5000;
    escapeTime = 10;
    keyMode = "vi";
    extraConfig = ''
      set -as terminal-features ",alacritty*:RGB"
      set-option -sa terminal-overrides ",alacritty*:RGB"
      set-option -g focus-events on
      bind -n C-k send-keys -R C-l \; clear-history
    '';
  };

  programs.firefox.enable = true;

  programs.zoxide.enable = true;

  # Adds neovim nightly to pkgs
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  home.packages = [
    pkgs.aws-vault
    pkgs.awscli2
    pkgs.difftastic
    pkgs.dive
    pkgs.etcher
    pkgs.gcc
    pkgs.insomnia
    pkgs.kubectl
    pkgs.neovim-nightly
    pkgs.ruby
    pkgs.slack
    pkgs.spotify
    pkgs.tig
    pkgs.typos
    pkgs.zoom-us
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";
}
