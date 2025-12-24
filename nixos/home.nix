{ config, pkgs, ... }:

{
  home.username = "vaelen";
  home.homeDirectory = "/home/vaelen";
  home.stateVersion = "25.11";
  programs.bash.enable = true;
}
