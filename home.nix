# /etc/nixos/home.nix
{ config, pkgs, ... }:

let
  #==========================================#
  ## Theme Toggle
  ## Current available Themes: "lofi", "cyber"
  #==========================================#

  theme = "lofi";
in
{
  #==========================================#
  ## Basic identity configuration
  #==========================================#
  home.username = "nyhil";
  home.homeDirectory = "/home/nyhil";
  home.stateVersion = "24.05";
  home.file = { };
  programs.home-manager.enable = true;

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

  programs.zsh.enable = true;
  programs.waybar.enable = true;

  users.defaultUserShell = pkgs.zsh;


  #==========================================#
  ## Themed config files
  #==========================================#
  xdg.configFile."hypr/hyprland.conf".source          = ./dotfiles/${theme}/hypr/hyprland.conf;
  xdg.configFile."fastfetch/config.jsonc".source      = ./dotfiles/${theme}/fastfetch/config.jsonc;
  xdg.configFile."rofi/config.rasi".source            = ./dotfiles/${theme}/rofi/config.rasi;
  xdg.configFile."waybar/config.jsonc".source         = ./dotfiles/${theme}/waybar/config.jsonc;
  xdg.configFile."waybar/style.css".source            = ./dotfiles/${theme}/waybar/style.css;
  xdg.configFile."waybar/latte.css".source            = ./dotfiles/${theme}/waybar/latte.css;

}
