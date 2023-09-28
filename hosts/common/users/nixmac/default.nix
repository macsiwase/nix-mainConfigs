{ pkgs, config, ... }:
let ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
#  users.mutableUsers = false;
  users.users.nixmac = {
    isNormalUser = true;
    description = "nixmac";
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "video"
      "audio"
      "networkmanager"
    ] ++ ifTheyExist [
      "network"
      "wireshark"
      "i2c"
      "mysql"
      "docker"
      "podman"
      "git"
      "libvirtd"
      "deluge"
    ];

    # openssh.authorizedKeys.keys = [ (builtins.readFile ../../../../home/nixmac/ssh.pub) ];
    #passwordFile = config.sops.secrets.nixmac-password.path;
    packages = [ pkgs.home-manager ];
  };

   #sops.secrets.nixmac-password = {
   # sopsFile = ../../secrets.yaml;
   #  neededForUsers = true;
  #};

  home-manager.users.nixmac = import ../../../../home/nixmac/${config.networking.hostName}.nix;

#  services.geoclue2.enable = true;
#  security.pam.services = { swaylock = { }; };
}
