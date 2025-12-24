{ config, lib, pkgs, ... }:

let
  ida = pkgs.callPackage ./ida.nix {};
in

{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "uinput" ];
  boot.extraModprobeConfig = ''
	options iwlwifi power_save=0
	options iwlmvm power_scheme=1
	options cfg80211 ieee80211_regdom=FR
	options iwlwifi bt_coes_active=0
  '';

  networking.hostName = "foxdroid";
  services.resolved.enable = true;
  networking.networkmanager = {
	enable = true;
	wifi = {
		powersave = false;
		scanRandMacAddress = false;
	};
  };

  time.timeZone = "Europe/Paris";
  console.keyMap = "fr";

  fileSystems."/mnt/data" = {
	device = "/dev/disk/by-uuid/19d135e3-4cde-4132-9e90-2fc54d3b8a16";
	fsType = "ext4";
	options = [ "defaults" "noatime" ];
  };
  
  hardware.graphics = {
	enable = true;
	enable32Bit = true;
	extraPackages = with pkgs; [
		rocmPackages.clr.icd
		libva-vdpau-driver
	];
  };
  hardware.amdgpu.opencl.enable = true;
  
  services.xserver.enable = true;
  services.displayManager.gdm = {
	enable = true;
	wayland = true;
  };
  services.xserver.xkb.layout = "fr";
  services.xserver.xkb.options = "grp_led:scroll";

  services.pipewire = {
  	enable = true;
	pulse.enable = true;
  };
  
  users.users.vaelen = {
  	description = "Vaelen - Dev";
	isNormalUser = true;
	extraGroups = [ "wheel" "audio" "video" "input" "plugdev" ];
	packages = with pkgs; [ tree ];
  };

  hardware.openrazer = {
	enable = true;
	users = [ "vaelen" ];
  };
 
  services.hardware.openrgb.enable = true;

  programs.nix-ld.enable = true;
  nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.permittedInsecurePackages = [ "mbedtls-2.28.10" ];
  nix.settings = {
	experimental-features = [ "nix-command" "flakes" ];
  };
  
  # systemd.tmpfiles.rules = [ "d /home/vaelen/.idapro 0700 vaelen vaelen -" ];
  environment.systemPackages = with pkgs; [
	vim wget git fuzzel niri neovim xwayland-satellite xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk fastfetch brave avahi 
	(discord.override { withVencord = true; }) obs-studio nushell steam superfile mako ghostty mplayer ffmpeg moonlight-qt lutris wine gnome-keyring kdePackages.polkit-kde-agent-1 
	swaybg protonplus playerctl 
	iw razer-cli evtest avizo lm_sensors python3 nautilus unzip prismlauncher gtop appimage-run pipewire wireplumber libglvnd cava openrazer-daemon polychromatic tty-clock 
	sunshine obsidian zerotierone termius protonup-qt
	gamemode fuse nh zig zls zip mangohud blender corectrl
	ffmpegthumbnailer fd ripgrep file
	gcc clang gnumake cmake rustup pkg-config glibc fontconfig.dev freetype.dev vulkan-headers vulkan-validation-layers libGL wayland libxkbcommon alsa-lib zlib openssl curl icu dbus 
	gtk3 udev
	xorg.libX11 xorg.libXext xorg.libXcursor xorg.libXi xorg.libXrandr xorg.libXrender xorg.libXinerama xorg.libXScrnSaver xorg.libXfixes xorg.libxcb
	ida openrgb-with-all-plugins
  ];
  
  fonts.packages = with pkgs; [
  	nerd-fonts.iosevka noto-fonts noto-fonts-cjk-sans noto-fonts-color-emoji
  ];

  programs.niri.enable = true;
  programs.steam = {
	enable = true;
	extraCompatPackages = [ pkgs.proton-ge-bin ];
	remotePlay.openFirewall = true;
	dedicatedServer.openFirewall = true;
  };
  
  xdg.portal = {
  	enable = true;
	wlr.enable = true;
	extraPortals = with pkgs; [
		xdg-desktop-portal-gtk
		xdg-desktop-portal-gnome
		xdg-desktop-portal-wlr
	];
  };
  
  environment.etc."xdg-desktop-portal/niri-portal.conf".text = ''
	[preferred]
	default=gtk
	org.freedesktop.impl.portal.FileChooser=gtk
	org.freedesktop.impl.portal.AppChooser=gtk
	org.freedesktop.impl.portal.Print=gtk
	org.freedesktop.impl.portal.Notification=gtk
	org.freedesktop.impl.portal.Inhibit=gtk
	org.freedesktop.impl.portal.Access=gtk
	org.freedesktop.impl.portal.Account=gtk
	org.freedesktop.impl.portal.Email=gtk
	org.freedesktop.impl.portal.DynamicLauncher=gtk
	org.freedesktop.impl.portal.RemoteDesktop=wlr
	org.freedesktop.impl.portal.ScreenCast=wlr
	org.freedesktop.impl.portal.ScreenShot=wlr
  '';
  
  environment.sessionVariables = {
	XDG_CURRENT_DESKTOP = "niri";
	XDG_SESSION_TYPE = "wayland";
	GDK_BACKEND = "wayland";
	NIXOS_OZONE_WL = "1";
	MOZ_ENABLE_WAYLAND = "1";
	LD_LIBRARY_PATH = "/run/current-system/sw/lib";
	LIBRARY_PATH = "/run/current-system/sw/lib";
	PKG_CONFIG_PATH = "/run/current-system/sw/lib/pkgconfig";
  };
  
  systemd.user.services.polkit-agent = {
	description = "Polkit agent for Niri";
	wantedBy = [ "graphical-session.target" ];
	partOf = [ "graphical-session.target" ];
	serviceConfig = {
		Type = "simple";
		ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
		Restart = "on-failure";
	};
  };
  
  security.polkit.enable = true;
  programs.corectrl.enable = true;
  security.polkit.extraConfig = ''
	polkit.addRule(function(action, subject) {
		if (action.id == "org.corectrl.helper.init" && subject.local && subject.active && subject.isInGroup("video")) {
			return polkit.Result.YES;
		}
	});
  '';

  services.avahi = {
    enable = true;
    nssmdns4 = true;  # ou nssmdns = true; selon la version
    publish = {
      enable = true;
      userServices = true;
    };
  };
  
  services.sunshine = {
    enable = true;
    autoStart = false;
    capSysAdmin = true;
    openFirewall = true;
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 47984 47989 47990 48010 ];
    allowedUDPPortRanges = [
      { from = 47998; to = 48000; }
      { from = 48010; to = 48010; }
    ];
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?

}

