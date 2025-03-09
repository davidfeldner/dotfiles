# Nixos config

My Nixos hyprland config

# Hyprland nvidia desktop lag
In c9ddb6b nixpkgs was updated to kernel 6.12, which needs nvidia_drm.fbdev=1:
https://github.com/hyprwm/Hyprland/issues/7972#issuecomment-2388846887

But setting fbdev=1 causes freeze on desktop, so for now kernel is set to 6.6