{
  description = "Home Manager configuration of RC-14";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    scripts = {
      url = "github:RC-14/scripts";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, scripts, ... }@inputs:
    let
      user = rec {
        name = "RC-14";
        email = "61058098+RC-14@users.noreply.github.com";
        userName = "rc-14";
        homePath = "/Users/${userName}";
      };
      flakePath = "${user.homePath}/github/RC-14/home-manager";
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations.${user.userName} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./home.nix
          ./programs
          ./shell
        ];

        extraSpecialArgs = { inherit system user flakePath; scripts = scripts.packages.${system}; };
      };
    };
}
