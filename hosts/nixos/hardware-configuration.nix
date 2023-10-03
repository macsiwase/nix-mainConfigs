{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ 
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd = {
      availableKernelModules = [ "nvme" "ehci_pci" "xhci_pci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
      # Enable swap on luks.
      luks.devices."luks-ea34758d-436e-4677-ab03-0d5771032839".device = "/dev/disk/by-uuid/ea34758d-436e-4677-ab03-0d5771032839";
      luks.devices."luks-ea34758d-436e-4677-ab03-0d5771032839".keyFile = "/crypto_keyfile.bin";
      # Enable root on luks.
      luks.devices."luks-10782a9f-4861-485f-88c7-40b2ef5d63b4".device = "/dev/disk/by-uuid/10782a9f-4861-485f-88c7-40b2ef5d63b4";
    };
    kernelModules = [ "kvm-amd" ];
    loader = {
      systemd-boot = {
        enable = true;
      };
      efi.canTouchEfiVariables = true;
    };
  };

  fileSystems."/" = { 
    device = "/dev/disk/by-uuid/0a4d8fbc-492e-4455-873e-bc8454735583";
    fsType = "ext4";
  };

  fileSystems."/boot" = { 
    device = "/dev/disk/by-uuid/2626-207F";
    fsType = "vfat";
  };

  swapDevices = [{ 
    device = "/dev/disk/by-uuid/0f3fa7fb-f549-4d7b-9aa7-cce5fdaaa2d1"; }
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = true;
}
