{ pkgs, lib, config, inputs, ... }:

let
  pkgs-unstable = import inputs.nixpkgs-unstable { inherit (pkgs.stdenv) system; };
in {
  packages = [
    pkgs.git
    pkgs.jq
    pkgs.ripgrep
    pkgs.xh
  ];

  languages.python = {
    enable = true;
    venv.enable = true;
    uv = {
      enable = true;
      package = pkgs-unstable.uv;
      sync.enable = true;
    };
  };

  enterTest = ''
    echo "Running tests"
    git --version | grep "${pkgs.git.version}"
  '';

  pre-commit.hooks.ruff.enable = true;

  # See full reference at https://devenv.sh/reference/options/
}
