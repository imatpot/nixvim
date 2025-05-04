{...}: self: super: {
  vimPlugins =
    super.vimPlugins
    // {
      search = super.vimUtils.buildVimPlugin {
        name = "search.nvim";
        src = super.fetchFromGitHub {
          owner = "FabianWirth";
          repo = "search.nvim";
          rev = "7b8f2315d031be73e14bc2d82386dfac15952614";
          sha256 = "1cyjkw7vsdi1qmfmcm5lg51zc7gkmgj9a62d8g29i4yks49crjpk";
        };
        doCheck = false;
      };

      kak-nvim = super.vimUtils.buildVimPlugin {
        name = "kak.nvim";
        src = super.fetchFromGitHub {
          owner = "mirlge";
          repo = "kak.nvim";
          rev = "d4d55034232209d1476902ea004c48e01e06aa2a";
          sha256 = "0i8qc1gppxkb4xj09ikd18s45jhkfy0gvwff2g1y8c6b3mx7lh9a";
        };
        doCheck = false;
      };

      indentmini = super.vimUtils.buildVimPlugin {
        name = "indentmini.nvim";
        src = super.fetchFromGitHub {
          owner = "nvimdev";
          repo = "indentmini.nvim";
          rev = "b51cd09456c133b51115448dfb58e84465432029";
          sha256 = "06vqn4hbwb27dw2aas0qdym88lzyvkvd60i06wcm355drci7vqz7";
        };
        doCheck = false;
      };

      vim-troll-stopper = super.vimUtils.buildVimPlugin {
        name = "vim-troll-stopper";
        src = super.fetchFromGitHub {
          owner = "vim-utils";
          repo = "vim-troll-stopper";
          rev = "24a9db129cd2e3aa2dcd79742b6cb82a53afef6c";
          sha256 = "1avycg3nnb94kiz5sgfncg1aflg364zl57g65x8jps2zmv6bymp4";
        };
        doCheck = false;
      };
    };
}
