rec {
  bun = {
    path = ./bun;
    description = " Bun development environment (Bun runtime + tooling)";
  };

  default = {
    path = ./empty;
    description = "🧩 Empty starter flake with minimal dev shell";
  };

  go = {
    path = ./go;
    description = "󰟓 Go development environment (Go + common tools)";
  };

  nix = {
    path = ./nix;
    description = "󱄅 Nix development environment (nixd + formatters + tools)";
  };

  node = {
    path = ./node;
    description = "  Node.js development environment (Node 22 + pnpm + yarn)";
  };

  python = {
    path = ./python;
    description = " Python development environment (venv + pip + formatters)";
  };

  shell = {
    path = ./shell;
    description = " Shell scripting development environment (ShellCheck + shfmt)";
  };
}

