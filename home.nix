{ config
, pkgs
, ...
}:
let
  nixvim = import (builtins.fetchGit {
    url = "https://github.com/nix-community/nixvim";
  });
in
{
  imports = [
    # For home-manager
    nixvim.homeManagerModules.nixvim
    ./zsh.nix
    ./nvim/nvim.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = {
    username = "uriel";
    homeDirectory = "/home/uriel";

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "24.05"; # Please read the comment before changing.

    # The home.packages option allows you to install Nix packages into your
    # environment.
    packages = with pkgs; [
      # ***** Gnome and terminal *****
      gnome-extension-manager
      gnomeExtensions.vitals
      gnomeExtensions.user-themes
      gnomeExtensions.dash-to-panel
      gnomeExtensions.gtile
      everforest-gtk-theme
      htop
      bat
      xclip
      wget
      zsh
      zsh-syntax-highlighting
      xorg.xhost

      # ***** VPN *****
      openvpn
      networkmanager-openvpn
      gpauth
      gpclient

      # ***** Web *****
      firefox-devedition
      thunderbird
      chromium
      google-chrome

      # ***** Developpement *****
      git
      direnv
      nix-direnv
      alejandra
      dbeaver-bin
      realvnc-vnc-viewer
      #arduino-ide

      # ***** Social *****
      element-desktop
      teams-for-linux

      # ***** Edition *****
      libreoffice
      krita
      gimp

      # ***** Management *****
      notion
      gnucash
      obsidian

      # ***** Media *****
      vlc
      netflix
      # lutris

      # ***** Utils *****
      transmission_4-gtk
      simplescreenrecorder
      openrgb-with-all-plugins
      # cheese
    ];
  };
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "Vitals@CoreCoding.com"
        "dash-to-panel@jderose9.github.com"
        "gtile"
      ];
    };
    # "org/gnome/shell/extensions/user-theme" = {
    #   name = "Everforest-Dark-BL-GS";
    # };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Everforest-Dark-BL-LB";
      package = pkgs.everforest-gtk-theme;
    };
    iconTheme = {
      name = "Everforest-Dark";
      package = pkgs.everforest-gtk-theme;
    };
  };

  # home.sessionVariables.GTK_THEME = "Everforest-Dark-BL-LB";

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = { };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/uriel/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    SHELL = "/home/uriel/.nix-profile/bin/zsh";
  };

  programs = {
    #    zsh = {
    #      enable = true;
    #      enableCompletion = true;
    #      autosuggestion.enable = true;
    #      syntaxHighlighting.enable = true;
    #      shellAliases = {
    #        nixdev = "nix develop --command zsh";
    #        nixdirenv = "echo \"use flake\" >> .envrc && direnv allow";
    #        ddg = "web_search duckduckgo";
    #        ecosia = "web-search ecosia";
    #        cat = "bat --paging=never";
    #        # code = "flatpak run com.visualstudio.code";
    # osrd-project = "cd ~/Desktop/osrd-project/";
    # config-home-manager = "nvim ~/.config/home-manager/home.nix";
    #      };
    #
    #      oh-my-zsh = {
    #        enable = true;
    #        plugins = [
    #          "git"
    #          "direnv"
    #          "z"
    #          "copyfile"
    #          "web-search"
    #        ];
    #        custom = "$HOME/.oh-my-custom";
    #        theme = "af-magic";
    #      };
    #      plugins = [
    #        {
    #          name = "zsh-nix-shell";
    #          file = "nix-shell.plugin.zsh";
    #          src = pkgs.fetchFromGitHub {
    #            owner = "chisui";
    #            repo = "zsh-nix-shell";
    #            rev = "v0.8.0";
    #            sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
    #          };
    #        }
    #      ];
    #    };

    git = {
      enable = true;
      userName = "Uriel-Sautron";
      userEmail = "uriel.sautron@gmail.com";
      extraConfig = {
        rerere.enable = true;
        verbose.enable = true;
      };
      includes = [
        { path = "~/.gitconfig.local"; }
      ];
    };

    home-manager = {
      enable = true;
    };
  };
}
