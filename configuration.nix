# /etc/nixos/configuration.nix
{ config, pkgs, inputs, ... }:

{
  #==========================================#
  ## Imports
  #==========================================#
  imports = [
    ./hardware-configuration.nix

    # Home Manager NixOS module (provided by the home-manager channel)
    inputs.home-manager.nixosModules.default
  ];

  #==========================================#
  ## Bootloader / Kernel
  #==========================================#
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  #==========================================#
  ## Nix / Unfree
  #==========================================#
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  #==========================================#
  ## Hostname & Networking
  #==========================================#
  networking.hostName = "Malignant";
  networking.networkmanager.enable = true;

  #==========================================#
  ## Localization
  #==========================================#
  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "uk";
  services.xserver.xkb.layout = "gb";

  #==========================================#
  ## Desktop Environments / Compositors
  #==========================================#
  # Plasma 6 (X11 & Wayland sessions).
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;

  # Hyprland (Wayland compositor)
  programs.hyprland.enable = true;

  programs.zsh.enable = true;

  programs.firefox.enable = true;
  #==========================================#
  ## Sound (PipeWire replacing PulseAudio)
  #==========================================#
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  #==========================================#
  ## Users
  #==========================================#
  users.users.nyhil = {
    isNormalUser = true;
    description = "nyhil";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  users.users.guest = {
    isNormalUser = true;
    description = "Guest";
  };

  #==========================================#
  ## System Packages
  #==========================================#
  environment.systemPackages = with pkgs; [
    git
    wget
    psmisc
    btop
    eza
    tree
    wlogout
    hyprlock
  ];

  fonts.packages = [
    pkgs.nerd-fonts._0xproto
    pkgs.nerd-fonts.droid-sans-mono
    pkgs.nerd-fonts.symbols-only
  ];
  #==========================================#
  ## State Version
  #==========================================#
  system.stateVersion = "25.05";
}
