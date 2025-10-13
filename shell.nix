{ pkgs ? import <nixpkgs> {} }:

let 
  dotfilesRepo = "git@github.com:mielpeeters/.dotfiles";
  dotfilesDir = "${builtins.getEnv "HOME"}/.dotfiles";
in

pkgs.mkShell {
  name = "mielsh";
  buildInputs = with pkgs; [
    # Development tools
    git
    curl
    wget
    stow
    tree
    btop
    tmux
    zsh
    fzf
    ripgrep
    fd
    jq
    bat
    glow
    difftastic
    
    # Programming languages
    python3
    uv
    nodejs
    go
    rustc
    cargo
    typst
    
    # Text editors
    vim
    neovim

    # CLI
    starship
    bat
    eza
    lazygit
    yazi
  ];

  shellHook = ''
    echo "🚀 Nix shell install loaded"

    
    
    # Set default editor
    export EDITOR=nvim

    # use zsh
    export SHELL=${pkgs.zsh}/bin/zsh
    export ZSH="$HOME/.oh-my-zsh"

    echo "[+] Checking for dotfiles in ~/.dotfiles..."

    if [ ! -d "${dotfilesDir}" ]; then
      echo "[+] Cloning dotfiles..."
      git clone ${dotfilesRepo} "${dotfilesDir}"
    else
      echo "[~] Dotfiles already present."
    fi

    cd "${dotfilesDir}"

    echo "[+] Running stow to symlink configs..."
    for pkg in */; do
      pkg=''${pkg%/}
      echo "  --> stowing $pkg"
      stow --restow $pkg
    done

    cd $HOME

    # Optional: Install Oh My Zsh if it's not part of your dotfiles
    if [ ! -d "$ZSH" ]; then
      echo "[+] Installing Oh My Zsh..."
      git clone https://github.com/ohmyzsh/ohmyzsh.git "$ZSH"
    fi

    echo "[+] Launching Zsh with Oh My Zsh..."
    exec ${pkgs.zsh}/bin/zsh
  '';
}
