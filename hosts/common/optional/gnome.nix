{ pkgs, ... }:

{
  services = {
    xserver = {
      # Enable the X11 windowing system.
      enable = true;
      desktopManager.gnome = {
        enable = true;
      };
      displayManager.gdm = {
        enable = true;
      };
      # Configure keymap in X11.
      layout = "us";
      xkbVariant = "";
      # Enable touchpad support (enabled default in most desktopManager).
      #libinput.enable = true;
    };
    
    geoclue2.enable = true;
    
    # Enable flatpak.
    flatpak.enable = true;
    
    # Enable gnome-settings-daemon udev rules.
    udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  };
  
  # Fix broken stuff
  #services.avahi.enable = false;
  networking.networkmanager.enable = true;
  
  environment = {
    systemPackages = with pkgs; [
      gnomeExtensions.appindicator
      flatpak
      gnome.gnome-software
    ];
    
    # Exclude some GNOME applications.
    gnome.excludePackages = (with pkgs; [
      gnome-photos
      gnome-tour
    ]) ++ (with pkgs.gnome; [
      cheese # webcam tool
      gnome-music
      #gnome-terminal
      gedit # text editor
      epiphany # web browser
      geary # email reader
      evince # document viewer
      gnome-characters
      totem # video player
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
    ]);
  };
}
