{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

let
  pkgs-unstable = import inputs.nixpkgs-unstable { inherit (pkgs.stdenv) system; };
in
{
  packages = [
    pkgs.git
    pkgs.jq
    pkgs.ripgrep
    pkgs.xh
  ];

  languages = {
    python = {
      enable = true;
      venv.enable = true;
      uv = {
        enable = true;
        package = pkgs-unstable.uv;
        sync.enable = true;
      };
    };

    javascript = {
      enable = true;
      # 22 not available in cachix/devenv-nixpkgs/rolling yet
      # This builds from source on my computer and takes a while
      # maybe go with 21 for now
      package = pkgs-unstable.nodejs_22;
      npm = {
        enable = true;
        install.enable = true;
      };
    };

    typescript = {
      enable = true;
    };
  };


  enterTest = ''
    echo "Running tests"
    git --version | grep "2.44.0"
    jq --version | grep "1.7.1"
    rg --version | grep "14.1.0"
    xh --version | grep "0.21.0"
    uv --version | grep "0.4.30"
    python3 --version | grep "3.12.7"
    node --version | grep "22.10.0"
    npm --version | grep "10.9.0"
    tsc --version | grep "5.4.4"
  '';

  pre-commit.hooks.ruff.enable = true;

  # See full reference at https://devenv.sh/reference/options/
}
