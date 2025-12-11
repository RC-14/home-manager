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
    yazi.url = "github:sxyazi/yazi";
    yazi-plugins-repo = {
      url = "github:yazi-rs/plugins";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, scripts, yazi, yazi-plugins-repo }: let
    user = rec {
      name = "RC-14";
      email = "61058098+RC-14@users.noreply.github.com";
      userName = "rc-14";
      homePath = "/Users/${userName}";
    };
    flakePath = "${user.homePath}/github/RC-14/home-manager";
    system = "aarch64-darwin";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    homeConfigurations.${user.userName} = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [
        # Use bleeding edge Yazi directly from the main branch
        {
          nixpkgs.overlays = [ yazi.overlays.default ];
          nix.settings = {
            extra-substituters = [ "https://yazi.cachix.org" ];
            extra-trusted-public-keys = [ "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k=" ];
          };
        }

        # Load my config
        ./home.nix
        ./programs
        ./shell
      ];

      extraSpecialArgs = {
        inherit
          system
          user
          flakePath
          yazi-plugins-repo;

        scripts = scripts.packages.${system};
      };
    };
  };
}
