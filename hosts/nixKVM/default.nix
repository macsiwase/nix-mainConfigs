# This is your system's configuration file.

{ pkgs, inputs, ... }: {
  # Import other NixOS modules
  imports = [
     inputs.hardware.nixosModules.common-cpu-amd
     inputs.hardware.nixosModules.common-pc-laptop-ssd
     inputs.hardware.nixosModules.lenovo-thinkpad-t14-amd-gen1

     ./hardware-configuration.nix

     ../common/global
     ../common/users/nixmac
     
     ../common/optional/gamemode.nix
     #../common/optional/ckb-next.nix
     ../common/optional/greetd.nix
     ../common/optional/pipewire.nix
     ../common/optional/quietboot.nix
     #../common/optional/lol-acfix.nix
     #../common/optional/starcitizen-fixes.nix
  ];

  networking = {
    hostName = "nixKVM";
  };
  
  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen; 
  };
  
  programs = {
    #light.enable = true;
    adb.enable = true;
    dconf.enable = true;
    kdeconnect.enable = true;
  };
  
  # Lid settings
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };
  hardware = {
    opengl = {
      enable = true;
      extraPackages = with pkgs; [ amdvlk ];
      driSupport = true;
      driSupport32Bit = true;
    };
    #openrgb.enable = true;
    opentabletdriver.enable = true;
  };
   

  # Spice VDA. Enable bidirectional copy/paste etc host to/from VM.
  services.spice-vdagentd.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
