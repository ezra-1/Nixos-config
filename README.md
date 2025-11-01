# 🧊 Ezra’s NixOS + Home Manager Flake

A modular, reproducible NixOS setup powered by **flakes**, **Home Manager**, and a clean KDE Plasma 6 environment.  
Built for flexibility, transparency, and a little style ✨

---

## 📁 Structure Overview

```bash
.
├── flake.nix                # Main entry point (defines inputs, outputs, systems)
├── flake.lock               # Pinned versions for reproducibility
├── hosts/                   # Host-specific system configs (hardware, NixOS modules)
│   └── ezra/                # Ezra’s system setup
├── home/                    # Home Manager user configs
│   └── ezra/                # Ezra’s personal home config
├── overlays/                # Custom package overlays
├── pkgs/                    # Locally defined or extended packages
└── common/                  # Shared configuration (system-wide defaults)
```

---

## ⚙️ Features

### 🧩 System
- Flake-based configuration (`nix-command` + `flakes` enabled by default)
- `systemd-boot` with EFI support  
- Latest Linux kernel + firmware (`b43`, `kvm-intel`)

### 🌐 Networking
- NetworkManager for wireless + wired
- Bluetooth fully enabled

### 🖥️ Desktop
- **Plasma 6** desktop  
- **SDDM** display manager  
- Kvantum style for Qt apps

### 👤 User Setup
- User: `ezra`  
- Shell: `zsh` (with autosuggestions + syntax highlighting)  
- Managed by Home Manager  
- Includes personal dotfiles + session variables

### 📦 Packages
Essential tools & apps — developer-focused with a lightweight touch:
```
git, vim, neovim, kitty, vscode, spotify,
nodejs_24, gcc, fzf, fastfetch, prettierd,
dwt1-shell-color-scripts, nerd-fonts.jetbrains-mono
```

### 🧰 Services
- OpenSSH (secure, root login disabled)
- Flatpak (for sandboxed apps)

### 🌍 Locale
- **Timezone:** `America/Jamaica`  
- **Locale:** `en_US.UTF-8`

---

## 🧱 Overlays

- `additions` → Custom packages from `pkgs/`
- `modifications` → Overrides for existing packages
- `stable-packages` → Imports stable Nixpkgs channel (with unfree enabled)

---

## 💡 Commands

### Build System
```bash
sudo nixos-rebuild switch --flake .#ezra
```

### Apply Home Manager
```bash
home-manager switch --flake .#ezra
```

### Update Inputs
```bash
nix flake update
```

---

## 🧠 Philosophy

> “Simple, modular, reproducible — every line should earn its place.”

Ezra’s NixOS configuration isn’t just a system; it’s a foundation for creativity.  
Built to evolve, experiment, and stay reproducible — always.

---

## 🔗 Repo

👉 [github.com/ezra-1/Nixos-config](https://github.com/ezra-1/Nixos-config)

---

## 🧊 License

MIT — reuse, remix, and rebuild freely.
