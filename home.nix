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
    initExtra = ''
     setopt HIST_IGNORE_ALL_DUPS
     setopt HIST_SAVE_NO_DUPS 
     eval "$(jump shell zsh --bind=z)"
    '';
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "tmux" "asdf" ];
      theme = "robbyrussell";
    };
    envExtra = "ZSH_TMUX_AUTOSTART=true";
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
    };
  };

  programs.tmux = {
    enable = true;
#    historyLimit = 5000;
#    escapeTime = 10;
#    keyMode = "vi";
#    extraConfig = ''
#      set -as terminal-features ",alacritty*:RGB"
#      set-option -g focus-events on
#    '';
  };

  home.file = {
    ".tmux.conf".source = ./tmux.conf;
  };

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
