rec {
  default = {
    path = ./empty;
    description = "🧩 Empty starter flake with minimal dev shell";
  };

  go = {
    path = ./go;
    description = "🐹 Go development environment (Go + common tools)";
  };

  node = {
    path = ./node;
    description = "🚀 Node.js development environment (Node 22 + pnpm + yarn)";
  };
}

