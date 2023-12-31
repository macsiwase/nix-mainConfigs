{ pkgs, lib, config, ... }:
let
  ssh = "${pkgs.openssh}/bin/ssh";
 in
{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "macsiwase";
    userEmail = "github.impairers@simplelogin.co";
    extraConfig = {
      feature.manyFiles = true;
      init.defaultBranch = "main"; 
      credential.helper = "${
            pkgs.git.override { withLibsecret = true; }
           }/bin/git-credential-libsecret";
      #commit.gpgSign = true;
      #gpg.program = "${config.programs.gpg.package}/bin/gpg2";
    };
    lfs.enable = true;
    ignores = [ ".direnv" "result" ];
  };
}
