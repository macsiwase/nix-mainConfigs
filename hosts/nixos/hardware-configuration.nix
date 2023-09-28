# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "ehci_pci" "xhci_pci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/8bda9147-97f1-4234-8d0d-d41ca895a9d8";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-278c6436-c6f9-408f-b08e-8561c32bec10".device = "/dev/disk/by-uuid/278c6436-c6f9-408f-b08e-8561c32bec10";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/51EB-B93D";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/2f303ea8-a17c-4c7c-8d33-d3f9dd343381"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp1s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
