{ config, pkgs, ... }:

let
  
  home_directory = builtins.getEnv "HOME";
  log_directory = "${home_directory}/logs";

in

{
  
  imports = [
    ./home-manager/import.nix
  ];


  programs.autorandr = {
    enable = true;
  };


  xdg = {
    enable = true;
    cacheHome = "${home_directory}/.local/cache";
    configHome = "${home_directory}/.config/xdg";
    configFile."user-dirs.locale".text = "en_US";
    configFile."htop/htoprc".text = ''
        account_guest_in_cpu_meter=0
        color_scheme=0
        cpu_count_from_zero=0
        delay=15
        detailed_cpu_time=0
        fields=0 48 17 18 38 39 40 2 46 47 49 1
        header_margin=1
        hide_kernel_threads=1
        hide_threads=0
        hide_userland_threads=0
        highlight_base_name=0
        highlight_megabytes=1
        highlight_threads=1
        left_meter_modes=1 1 1
        left_meters=AllCPUs Memory Swap
    '';
  };
  programs.home-manager = {
    enable = true;
    path = "${home_directory}/.nix-defexpr/channels/home-mananger";
  };

  services.lorri.enable = true;

  systemd.user.startServices = true;
  # home.sessionVariables = {

  # };

}
