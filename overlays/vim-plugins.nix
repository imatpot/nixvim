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
          rev = "b9a7cc37dfd02084087540ba8a1cdb174716b31f";
          sha256 = "0w69xbmk8s05h0c34d426fjmg217d8475mhbqfaxm92zqvlczdsg";
        };
        doCheck = false;
      };

      indentmini = super.vimUtils.buildVimPlugin {
        name = "indentmini.nvim";
        src = super.fetchFromGitHub {
          owner = "nvimdev";
          repo = "indentmini.nvim";
          rev = "6211f93b0c8161d2a2b4000b9bf0c01c0a115455";
          sha256 = "05mbzqwqnr96g43b9lw7hfhzs0saz7p7j9n2y5rb6cz8ajfwmnyj";
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

      plenary-nvim = super.vimUtils.buildVimPlugin {
        name = "plenary-nvim";
        src = super.fetchFromGitHub {
          owner = "nvim-lua";
          repo = "plenary.nvim";
          rev = "857c5ac632080dba10aae49dba902ce3abf91b35";
          sha256 = "0jxx9nfga7z87v78cifglqs8w4mrpf99wcp483kb0hbv6537jmgh";
        };
        doCheck = false;
      };

      pubspec-assist = super.vimUtils.buildVimPlugin {
        name = "pubspec-assist.nvim";
        src = super.fetchFromGitHub {
          owner = "nvim-flutter";
          repo = "pubspec-assist.nvim";
          rev = "c79dbf94967d69dbabc1f7ad35662eb79a007b4b";
          sha256 = "1mymhnn3mlrjx55na1lxll41iy8g1bqqq644k179nd50xrjbdmmf";
        };
        doCheck = false;
      };

      deno-nvim = super.vimUtils.buildVimPlugin {
        name = "deno-nvim";
        src = super.fetchFromGitHub {
          owner = "sigmaSd";
          repo = "deno-nvim";
          rev = "5a2f9205df5539c4a0696e73893bf8d1b0cae406";
          sha256 = "1l75wk79hc358h4cg35l4x07igdqy3yrrbf0ca9w80rg7i95nagr";
        };
        doCheck = false;
      };

      nx-nvim = super.vimUtils.buildVimPlugin {
        name = "nx.nvim";
        src = super.fetchFromGitHub {
          owner = "Equilibris";
          repo = "nx.nvim";
          rev = "f8a3a21b3d540889401a40d1f2803083794c0372";
          sha256 = "1yn7k6ki1f5f3l0avfpzmj9mg62icxbvhp16w0q9vsxsis1yspk2";
        };
        doCheck = false;
      };
    };
}
