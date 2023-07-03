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
          { key = "c", mods = "LEADER",       action=wezterm.action{SpawnTab="CurrentPaneDomain"}},
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
    extraConfig = {
      core.editor = "nvim";
      commit.template = "~/.dotfiles/gitmessage";
      diff.external = "difft";
      push.autoSetupRemote = true;
    };
  };

  programs.firefox.enable = true;

  # jump
  programs.zoxide.enable = true;

  # obs-studio
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      #wlrobs
      #obs-pipewire-audio-capture
    ];
  };

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
    pkgs.flameshot
    pkgs.gcc
    pkgs.insomnia
    pkgs.kubectl
    pkgs.neovim-nightly
    pkgs.ruby_3_0
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
