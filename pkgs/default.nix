{ pkgs ? import <nixpkgs> { } }: rec {

  # Packages with an actual source
  #rgbdaemon = pkgs.callPackage ./rgbdaemon { };
  shellcolord = pkgs.callPackage ./shellcolord { };
  #trekscii = pkgs.callPackage ./trekscii { };
  #speedtestpp = pkgs.callPackage ./speedtestpp { };
  #lando = pkgs.callPackage ./lando { };
  #tidal-dl = pkgs.python3Packages.callPackage ./tidal-dl { };
  #sitespeedio = pkgs.callPackage ./sitespeedio { };
  qt6gtk2 = pkgs.qt6Packages.callPackage ./qt6gtk2 { };

  # Personal scripts
  nix-inspect = pkgs.callPackage ./nix-inspect { };
  #minicava = pkgs.callPackage ./minicava { };
  primary-xwayland = pkgs.callPackage ./primary-xwayland { };
  wl-mirror-pick = pkgs.callPackage ./wl-mirror-pick { };
  #o = pkgs.callPackage ./xpo { };
  tly = pkgs.callPackage ./tly { };
  hyprslurp = pkgs.callPackage ./hyprslurp { };

  # My slightly customized plymouth theme, just makes the blue outline white
  plymouth-spinner-monochrome = pkgs.callPackage ./plymouth-spinner-monochrome { };
}
