{ config, pkgs, ... }:

let
  pkgsUnstable = import <nixpkgs-unstable> {};
in
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
    initExtra = ''
     setopt HIST_IGNORE_ALL_DUPS
     setopt HIST_SAVE_NO_DUPS 
     eval "$(jump shell zsh --bind=z)"
    '';
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "tmux" ];
      theme = "robbyrussell";
    };
    envExtra = ''
      ZSH_TMUX_AUTOSTART=true
      EDITOR=nvim
    '';
  };

  programs.alacritty = {
    enable = true;
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
    };
  };

  programs.tmux = {
    enable = true;
     #historyLimit = 5000;
     #escapeTime = 10;
     #keyMode = "vi";
     #extraConfig = ''
     #  set -as terminal-features ",alacritty*:RGB"
     #  set-option -g focus-events on
     #'';
  };

  home.file = {
    ".tmux.conf".source = ./tmux.conf;
  };

  programs.firefox = {
    enable = true;
  };

  # Adds neovim nightly to pkgs
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  home.packages = [
    pkgs.neovim-nightly
    pkgsUnstable.aws-vault
    pkgsUnstable.awscli2
    pkgsUnstable.difftastic
    pkgsUnstable.dive
    pkgsUnstable.etcher
    pkgsUnstable.insomnia
    pkgsUnstable.jump
    pkgsUnstable.krita
    pkgsUnstable.kube3d
    pkgsUnstable.kubectl
    pkgsUnstable.lens
    pkgsUnstable.slack
    pkgsUnstable.spotify
    pkgsUnstable.tig
    pkgsUnstable.vale
    pkgsUnstable.wezterm
    pkgsUnstable.zoom-us
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
