{ inputs, config, pkgs, ... }:
let sugar-dark = pkgs.callPackage ./sugar-dark.nix { };
in
{
  nixpkgs.config.allowUnfree = true;

  # === DESKTOP ENVIRONMENT ===
  # LXQt
  services.xserver.enable = true;
  services.xserver.desktopManager.lxqt.enable = true;
  services.displayManager.sessionPackages = [ pkgs.lxqt.lxqt-wayland-session ];
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };


  # SDDM
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    # theme = "sugar-dark";
    # extraPackages = [sugar-dark];
    theme = "catppuccin-mocha-mauve";
  };

  # PRINTING
  services.printing = {
    enable = true;
    drivers = [ pkgs.epson-escpr pkgs.epson-escpr2 ];
  };

  # WAYDROID
  virtualisation.waydroid.enable = true;
  virtualisation.waydroid.package = pkgs.waydroid-nftables;

  # KEYBOARD
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings.main = {
        meta = "overload(control, esc)";
        leftalt = "layer(meta)";
        esc = "leftalt";
      };
    };
  };

  # PROGRAMS
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/cookshop/.dotfiles";
  };
  programs.nm-applet.enable = true;
  programs.nix-ld.enable = true;
  environment.systemPackages = with pkgs; [
    inputs.waydroid_script.packages.x86_64-linux.default
    vim
    fzf
    yazi
    man
    less
    curl
    zsh
    bat
    git
    gh
    nwg-look

    kitty
    wl-clipboard
    # (pkgs.callPackage ./waydroid-helper.nix {})
    labwc
    sugar-dark
    (catppuccin-sddm.override {
      flavor = "mocha";
      accent = "mauve";
    })

    zed-editor
    localsend
    inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}
