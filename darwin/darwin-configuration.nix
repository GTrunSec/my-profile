{ config, pkgs,  ... }:
let
  pkgs = (import ~/.config/nixpkgs/nixos/channel/nixpkgs) { };
in
{
  imports =
    [ # Include the results of the hardware scan.
      #~/.config/nixpkgs/nixos/lang/r-darwin.nix
      # ~/.config/nixpkgs/nixos/lang/python-darwin.nix
      # ~/.config/nixpkgs/nixos/lang/go-darwin.nix
      #./tmux.nix
    ];
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  # bugs sudo mount -uw /
  # sudo darwin-rebuild switch -I darwin=/Users/gtrun/.nix-defexpr/channels/darwin -I nixpkgs=/Users/gtrun/.config/nixpkgs/channel/nixpkgs -I darwin-config=/Users/gtrun/.config/nixpkgs/darwin/darwin-configuration.nix -I nix-darwin=/Users/gtrun/.nix-defexpr/channels/nix-darwin
  environment.systemPackages = with pkgs; [
    (import ~/.nix-defexpr/channels/home-manager {}).home-manager
    dbus
    go
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
    #vips
    libxml2
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
  programs.zsh.enable = true;
  #environment.interactiveShellInit = "source /etc/tmux.conf";
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  nix = {
    nixPath = [
      "darwin-config=$HOME/.config/nixpkgs/darwin/darin-configuration.nix"
      "home-manager=$HOME/.nix-defexpr/channels/home-manager/"
      "nixpkgs=$HOME/.config/nixpkgs/nixos/channel/nixpkgs"
      "ssh-config-file=$HOME/.ssh/config"
      #"ssh-auth-sock=${xdg_configHome}/gnupg/S.gpg-agent.ssh"
    ];

    binaryCaches = [
    ];

    
    binaryCachePublicKeys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nsm-data-analysis.cachix.org-1:GhKJmne4IPk5C78jG980Dijd+XGFZgOGULp3UKHkJ8M="
      "10.220.170.113:qJ56F7LuZnSS8LrgNnikUK8OfgI7nQXwYwa/8dA6wW8="
    ];

    trustedBinaryCaches = [
      https://cache.nixos.org
      https://nsm-data-analysis.cachix.org
      http://10.220.170.113
    ];



    trustedUsers = [ "gtrun"];
  };

  users.users.gtrun = {
    home = "/home/gtrun";
    shell = "/run/current-system/sw/bin/zsh";
       };
  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix.maxJobs = 15;
  nix.buildCores = 8;
}

