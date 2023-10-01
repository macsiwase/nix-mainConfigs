# Mac's NixOS Configurations
My new NixOS master config replacing the older version created on Sept 14, 2022.

Setup with LUKS, git-libsecret, home-manager standalone and flakes.

To apply updates with default NixOS host, run `./update-flakes.sh` and/or `./update-home.sh`.

## Installation

- Install git and enable Flakes in `/etc/nixos/configuration.nix`:

```
  # Enable Flakes and the new command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    # Flakes use Git to pull dependencies from data sources, so Git must be installed first
    git
    vim
    wget
    curl
  ];
  # Set default editor to vim
  environment.variables.EDITOR = "vim";
```

Then apply the changes by running `sudo nixos-rebuild switch`.

- Create a folder for the configurations and link a git repository:

```
mkdir NixOSConfigs
git clone https://github.com/macsiwase/nix-mainConfigs.git NixOSConfigs
cd NixOSConfigs
```

- Update disk partitions in `~/NixOSConfigs/hosts/nixos/default.nix`, `~/NixOSConfigs/hosts/nixos/hardware-configuration.nix` and `flake.nix` then run `sudo nixos-rebuild switch --flake .#hostname` to apply the system configuration.

- To enable home-manager, run `nix shell nixpkgs#home-manager` then run `home-manager switch --flake .#username@hostname` to apply the home configuration.

- Finally `git add`, `git commit` and `git push` the changes!

Now have fun and install other packages/services.

## Useful Tips

- [NixOS Search](https://search.nixos.org/packages)
- [NixOS Wiki](https://nixos.wiki/)

## Issues

