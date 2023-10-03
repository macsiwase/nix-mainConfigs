{ inputs, outputs, ... }: 
{
  imports = [
    ./global
  ];
   
  wallpaper = outputs.wallpapers.aenami-lunar;
  colorscheme = inputs.nix-colors.colorSchemes.atelier-heath;
}
