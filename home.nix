{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "nyhil";
  home.homeDirectory = "/home/nyhil";
  home.stateVersion = "25.05"; # Please read the comment before changing.



  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    kitty
    amberol

  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {

  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.waybar.enable = true;
}
