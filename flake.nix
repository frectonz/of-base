{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    utils.url = "github:numtide/flake-utils";
    rescript-lsp = {
      url = "github:frectonz/rescript-lsp-nix";
      inputs.utils.follows = "utils";
    };
  };

  outputs =
    { self
    , nixpkgs
    , utils
    , rescript-lsp
    }:
    utils.lib.eachDefaultSystem
      (system:
      let
        pkgs = import nixpkgs { inherit system; };
        rescript-language-server = rescript-lsp.packages.${system}.default;
      in
      with pkgs; {
        devShells.default = mkShell {
          packages = [
            nodejs
            nodePackages.pnpm
            rescript-language-server
            nodePackages."@tailwindcss/language-server"
          ];
        };

        formatter = nixpkgs-fmt;
      });
}
