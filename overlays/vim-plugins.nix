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
          rev = "0dc4bc2b3fc763420793e748b672292bc43ee722";
          sha256 = "1n8vb7wgkb81x9zqhmsdrl2ilx40l4r6jg9qnmd3ihbfwbsjgi48";
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

      telescope-git-conflicts = super.vimUtils.buildVimPlugin {
        name = "telescope-git-conflicts.nvim";
        src = super.fetchFromGitHub {
          owner = "Snikimonkd";
          repo = "telescope-git-conflicts.nvim";
          rev = "1ac7040f601d16ab3800bdda6f5912a0e385cb29";
          sha256 = "0n5jwc7pv14fipavqfvam5691qp9fvs2nksdaihjgqrgl5sd12jv";
        };
        doCheck = false;
      };

      workspace-diagnostics = super.vimUtils.buildVimPlugin {
        name = "workspace-diagnostics.nvim";
        src = super.fetchFromGitHub {
          owner = "artemave";
          repo = "workspace-diagnostics.nvim";
          rev = "60f9175b2501ae3f8b1aba9719c0df8827610c8e";
          sha256 = "1plx01fcwqxym5z86wfwvc52if2qm5nfg51skxzjmjn6m5l4lald";
        };
        doCheck = false;
      };

      hml = super.vimUtils.buildVimPlugin {
        name = "hml.nvim";
        src = super.fetchFromGitHub {
          owner = "mawkler";
          repo = "hml.nvim";
          rev = "54b4d0a4d800f79310443f9a26d54023daeb9e7c";
          sha256 = "0892cljk7ddw43cihc3yf06ccssbvgg7y8acln9mlhxq8b5iinr1";
        };
        doCheck = false;
      };
    };
}
