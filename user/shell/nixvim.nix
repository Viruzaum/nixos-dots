{inputs, ...}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    vimAlias = true;
    colorschemes.gruvbox.enable = true;
    opts = {
      number = true;
      relativenumber = true;

      shiftwidth = 2;
    };

    plugins = {
      lualine.enable = true;

      lsp = {
        enable = true;
        servers = {
          # nix
          nil_ls.enable = true;

          # rust
          rust-analyzer.enable = true;
          rust-analyzer.installCargo = true;
          rust-analyzer.installRustc = true;
        };
      };

      cmp = {
        enable = true;
      };

      treesitter.enable = true;

      luasnip.enable = true;
    };

    clipboard.providers.wl-copy.enable = true;
  };
}
