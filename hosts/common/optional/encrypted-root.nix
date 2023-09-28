{ config, ... }:
let hostname = config.networking.hostName;
in {
  boot.initrd = {
    secrets ={
      "/crypto_keyfile.bin" = null;
    };
  # swap on luks
  #  luks.devices."${hostname}".device = "/dev/disk/by-label/${hostname}_crypt";
  luks.devices."luks-67d66c80-ad88-4618-bc82-707a1c353895".device = "/dev/disk/by-uuid/67d66c80-ad88-4618-bc82-707a1c353895";
  luks.devices."luks-278c6436-c6f9-408f-b08e-8561c32bec10".device = "/dev/disk/by-uuid/278c6436-c6f9-408f-b08e-8561c32bec10";
  luks.devices."luks-67d66c80-ad88-4618-bc82-707a1c353895".keyFile = "/crypto_keyfile.bin"; 
   # luks.devices."${hostname}".keyFile = "/crypto_keyfile.bin";
  };
}
