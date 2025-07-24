# /etc/nixos/home.nix
{ config, pkgs, lib, theme ? cyber, ... }:

let
  #==========================================#
  ## Theme Toggle
  ## Current available Themes: "lofi", "cyber"
  #==========================================#

  dotfilesRoot = /etc/nixos/dotfiles;
  themeDir = dotfilesRoot + "/${theme}";

  mkCfgDir = name: {
    source = themeDir + "/${name}";
    recursive = true;
    force = true;
  };
in
{
  #==========================================#
  ## Basic identity configuration
  #==========================================#
  home.username = "nyhil";
  home.homeDirectory = "/home/nyhil";
  home.stateVersion = "24.05";
  home.file = {}

  programs.home-manager.enable = true;
  xdg.enable = true;

  #==========================================#
  ## User specific packages
  #==========================================#
  home.packages = with pkgs; [
    kitty
    amberol
    swww
    playerctl
    gedit
    sl
  ];

  programs.waybar.enable = true;


  #==========================================#
  ## Themed config files
  #==========================================#
  xdg.configFile = {
    "hypr"      = mkCfgDir "hypr";
    "waybar"    = mkCfgDir "waybar";
    "rofi"      = mkCfgDir "rofi";
    "fastfetch" = mkCfgDir "fastfetch";

  };

}
