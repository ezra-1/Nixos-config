rec {
  default = {
    path = ./empty;
    description = "🧩 Empty starter flake with minimal dev shell";
  };
  node = {
    path = ./node;
    description = "🚀 Node.js development environment (Node 22 + pnpm + yarn)";
  };
}

