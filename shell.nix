{ pkgs, lib, config, inputs, ... }:

{
  packages = [
    pkgs.git
    pkgs.jq
    pkgs.ripgrep
    pkgs.xh
  ];

  languages.python.uv.enable = true;
  languages.python.uv.sync.enable = true;

  enterTest = ''
    echo "Running tests"
    git --version | grep "${pkgs.git.version}"
  '';

  pre-commit.hooks.ruff.enable = true;

  # See full reference at https://devenv.sh/reference/options/
}
