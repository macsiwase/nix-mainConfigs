{ inputs, outputs, ... }: 
{
  imports = [
    ./global
    ./features/desktop/common
  ];
   
  wallpaper = outputs.wallpapers.aenami-lunar;
  colorscheme = inputs.nix-colors.colorSchemes.atelier-heath;
}
