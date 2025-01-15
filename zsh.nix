{ pkgs, ... }:

{
  programs = {
   zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        nixdev = "nix develop --command zsh";
        nixdirenv = "echo \"use flake\" >> .envrc && direnv allow";
        ddg = "web_search duckduckgo";
        ecosia = "web-search ecosia";
        cat = "bat --paging=never";
        code = "flatpak run com.visualstudio.code";
	osrd-project = "cd ~/Desktop/osrd-project/";
	config-home-manager = "nvim ~/.config/home-manager/home.nix";
	config-zsh = "nvim ~/.config/home-manager/zsh.nix";
	home-manager-folder = "nvim ~/.config/home-manager";
      };

      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "direnv"
          "z"
          "copyfile"
          "web-search"
        ];
        custom = "$HOME/.oh-my-custom";
        theme = "af-magic";
      };
      plugins = [
        {
          name = "zsh-nix-shell";
          file = "nix-shell.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "chisui";
            repo = "zsh-nix-shell";
            rev = "v0.8.0";
            sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
          };
        }
      ];

      initExtra = "source ~/.config/home-manager/auto-launching-ssh-agent";
    };
  };
}
