{ inputs, config, pkgs, ... }:
let
 inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  programs.home-manager.enable = true;

  home.username = "devin";
  home.homeDirectory = "/home/devin";


  home.packages = with pkgs; [
  ];

  home.stateVersion = "24.05";

 # programs = {
  #  #fzf = (import ./fzf.nix { inherit pkgs; });
 # };

  # gtk = {
  #   enable = true;
    # gtk3.extraConfig.gtk-decoration-layout = "menu:";
    # theme = {
    #   name = "Tokyonight-Dark-B";
    #   package = pkgs.tokyo-night-gtk;
    # };
    # iconTheme = {
    #   name = "Tokyonight-Dark";
    # };
  #   # cursorTheme = {
  #   #   name = gtkCursorTheme;
  #   #   package = pkgs.bibata-cursors;
  #   # };
  # };

  #wayland.windowManager = {
  #  hyprland = (import ./hyprland.nix { inherit pkgs; });
  #};
}
