{ inputs, pkgs, lib, ... }: 

{
  imports = [
     inputs.hardware.nixosModules.common-cpu-amd
     inputs.hardware.nixosModules.common-pc-laptop-ssd
     inputs.hardware.nixosModules.lenovo-thinkpad-t14-amd-gen1

    ./hardware-configuration.nix
    
    ../common/global
    ../common/users/nixmac
    
    ../common/optional/pipewire.nix
    ../common/optional/quietboot.nix
    ../common/optional/gnome.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen; 
  };
  
  networking = {
    hostName = "nixos";
    useDHCP = lib.mkDefault true;
  };
  # networking.wireless.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

 # List packages installed in system profile. To search, run:
 # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    kitty
  ];

  programs = {
    dconf.enable = true;
    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    mtr.enable = true;
    gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
    };
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
  #services.spice-vdagentd.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
