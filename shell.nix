{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    # Development tools
    git
    curl
    wget
    tree
    btop
    tmux
    zsh
    fzf
    ripgrep
    fd
    bat
    eza
    jq
    bat
    lazygit
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
  ];

  shellHook = ''
    echo "🚀 Nix shell install loaded"
    
    # Set up shell aliases
    alias find='fd'
    alias grep='rg'
    alias lg="lazygit"
    alias j="just"
    alias cat="bat"
    alias ls="eza"
    alias l="eza -lah --group-directories-first --icons=always"
    
    # Custom shell prompt (optional)
    export PS1="\[\033[1;32m\][nix-shell]\[\033[0m\] \[\033[1;34m\]\w\[\033[0m\] $ "
    
    # Set default editor
    export EDITOR=nvim
  '';
}
