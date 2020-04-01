{ config, pkgs,  ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ~/.config/nixpkgs/nixos/lang/r-darwin.nix
      ~/.config/nixpkgs/nixos/lang/python-darwin.nix
      ~/.config/nixpkgs/nixos/lang/go-darwin.nix
      ./tmux.nix
      ./home-file.nix
    ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  # bugs sudo mount -uw /
  environment.systemPackages = with pkgs; [
    emacs
    dbus
    go
    zeek
    (bundler.overrideAttrs(old:  {
      name = "bundler-2.1.4";
      src = pkgs.fetchurl {
        url = "https://rubygems.org/gems/bundler-2.1.4.gem";
        sha256 = "12glbb1357x91fvd004jgkw7ihlkpc9dwr349pd7j83isqhls0ah";
      };
      postFixup = ''
          mv $out/bin/bundle $out/bin/ruby-bundle
          sed -i -e "s/activate_bin_path/bin_path/g" $out/bin/ruby-bundle
            '';
    }))
    jekyll
    glib
    vips
    libxml2
    (texlive.combine # latex + packages
      { inherit (texlive)
        collection-plaingeneric
        collection-latexextra
        collection-fontsrecommended
        collection-pictures
        collection-bibtexextra
        collection-mathscience
        collection-langgerman
        scheme-basic
        xetex
        cjk
        ctex
        xecjk
        fontspec euenc;
      }
    )
    julia_13
    wakatime
    ];

  environment.variables = { GOROOT = [ "${pkgs.go.out}/share/go" ]; };
  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.bash.enable = true;
  # programs.zsh.enable = true;
  programs.fish.enable = true;
  #environment.interactiveShellInit = "source /etc/tmux.conf";
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  nix = {
      nixPath = [
      "darwin-config=$HOME/.config/nixpkgs/darwin/darin-configuration.nix"
      "home-manager=$HOME/.config/nixpkgs/home-manager"
      "nixpkgs=$HOME/.config/nixpkgs/channel/nixpkgs"
      "ssh-config-file=$HOME/.ssh/config"
      #"ssh-auth-sock=${xdg_configHome}/gnupg/S.gpg-agent.ssh"
    ];

    binaryCaches = [
    ];

    
    binaryCachePublicKeys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nsm-data-analysis.cachix.org-1:GhKJmne4IPk5C78jG980Dijd+XGFZgOGULp3UKHkJ8M="
    ];

      trustedBinaryCaches = [
        https://cache.nixos.org
        https://nsm-data-analysis.cachix.org
      ];

      

      trustedUsers = [ "gtrun"];
  };

  users.users.gtrun = {
    home = "/home/gtrun";
    shell = "/run/current-system/sw/bin/fish";
       };
  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix.maxJobs = 15;
  nix.buildCores = 8;
}

