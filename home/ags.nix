{ inputs, pkgs, ... }:
{
  imports = [ inputs.ags.homeManagerModules.default ];

  home.packages = with pkgs; [
    pywal
    sassc
    (python312.withPackages (p: [
      p.materialyoucolor
      p.pillow
      p.pywayland
    ]))
    ydotool
    libnotify
    xorg.xrandr
    swww
    yad
    playerctl
    material-symbols
    dart-sass
    jq
  ];

  programs.ags = {
    enable = true;
    configDir = null; # if ags dir is managed by home-manager, it'll end up being read-only. not too cool.
    # configDir = ./.config/ags;

    extraPackages = with pkgs; [
      gtksourceview
      gtksourceview4
      python312Packages.pywayland
      pywal
      sassc
      webkitgtk
      webp-pixbuf-loader
      ydotool
    ];
  };
}
