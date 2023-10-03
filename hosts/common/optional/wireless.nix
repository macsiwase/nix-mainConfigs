{ config, lib, ... }: {
  # Wireless secrets stored through sops
#  sops.secrets.wireless = {
#    sopsFile = ../secrets.yaml;
#    neededForUsers = true;
#  };

  networking.wireless = {
    enable = true;
    fallbackToWPA2 = true;
    # Declarative
    environmentFile = config.sops.secrets.wireless.path;
    networks = { 
       "Vagabond" = {
         psk = "";
       };
#      "Marcos_5Ghz" = {
#        pskRaw = "@MARCOS_50@";
#      };

#      "eduroam" = {
#        auth = ''
#          key_mgmt=WPA-EAP
#          pairwise=CCMP
#          auth_alg=OPEN
#          eap=PEAP
#          identity="10856803@usp.br"
#          password="@EDUROAM@"
#          phase2="auth=MSCHAPV2"
#        '';
#      };
    };

    # Imperative
    allowAuxiliaryImperativeNetworks = true;
    userControlled = {
      enable = true;
      group = "network";
    };
    extraConfig = ''
      update_config=1
    '';
  };

  # Ensure group exists
  users.groups.network = { };

  systemd.services.wpa_supplicant.preStart = "touch /etc/wpa_supplicant.conf";
}
