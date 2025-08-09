{ config, pkgs, ... }:

{
  # Development tools and utilities
  environment.systemPackages = with pkgs; [
    # Version control
    gitui
    lazygit
    
    # Code quality and formatting
    shellcheck
    shfmt
    black
    nodePackages.prettier
    
    # Build tools
    ninja
    meson
    
    # Debugging and profiling
    gdb
    valgrind
    
    # Documentation
    man-pages
    man-pages-posix
    
    # Database clients
    sqlite
    postgresql_15
    
    # API testing
    postman
    insomnia
    
    # Container development
    docker-compose
    
    # Network tools
    httpie
    jq
    yq
  ];
}
