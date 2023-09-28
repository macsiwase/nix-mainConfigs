{ outputs, inputs }:
let
  addPatches = pkg: patches: pkg.overrideAttrs (oldAttrs: {
    patches = (oldAttrs.patches or [ ]) ++ patches;
  });
in
{
  # For every flake input, aliases 'pkgs.inputs.${flake}' to
  # 'inputs.${flake}.packages.${pkgs.system}' or
  # 'inputs.${flake}.legacyPackages.${pkgs.system}' or
  flake-inputs = final: _: {
    inputs = builtins.mapAttrs
      (_: flake: (flake.legacyPackages or flake.packages or { }).${final.system} or { })
      inputs;
  };

  # Adds my custom packages
  additions = final: prev: import ../pkgs { pkgs = final; } // {
    formats = prev.formats // import ../pkgs/formats { pkgs = final; };
    vimPlugins = prev.vimPlugins // final.callPackage ../pkgs/vim-plugins { };
  };

  # Modifies existing packages
  modifications = final: prev: {
    vimPlugins = prev.vimPlugins // {
      vim-numbertoggle = addPatches prev.vimPlugins.vim-numbertoggle [ ./vim-numbertoggle-command-mode.patch ];
    };

    # https://github.com/NixOS/nix/issues/5567#issuecomment-1193259926
    # nix = addPatches prev.nix [ ./nix-make-installables-expr-context.patch ];

    # https://gitlab.com/CalcProgrammer1/OpenRGB/-/issues/2918
    openrgb = addPatches prev.openrgb [ ./openrgb-all-devices.diff ];

    xdg-utils-spawn-terminal = addPatches prev.xdg-utils [ ./xdg-open-spawn-terminal.diff ];
  };
}
