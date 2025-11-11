rec {
  bun = {
    path = ./bun;
    description = " Bun development environment (Bun runtime + tooling)";
  };

  default = {
    path = ./empty;
    description = "🧩 Empty starter flake with minimal dev shell";
  };

  deno = {
    path = ./deno;
    description = " Deno development environment (Deno runtime + tooling)";
  };

  go = {
    path = ./go;
    description = "󰟓 Go development environment (Go + common tools)";
  };

  lua = {
    path = ./lua;
    description = " Lua development environment (Lua + Luarocks + formatters)";
  };

  nix = {
    path = ./nix;
    description = "󱄅 Nix development environment (nixd + formatters + tools)";
  };

  node = {
    path = ./node;
    description = " Node.js development environment (Node 22 + pnpm + yarn)";
  };

  python = {
    path = ./python;
    description = " Python development environment (venv + pip + formatters)";
  };

  rust = {
    path = ./rust;
    description = " Rust development environment (Rustup + Cargo + Clippy + Rustfmt)";
  };

  shell = {
    path = ./shell;
    description = " Shell scripting development environment (ShellCheck + shfmt)";
  };

  zig = {
    path = ./zig;
    description = " Zig development environment (Zig compiler + build tools)";
  };
}

