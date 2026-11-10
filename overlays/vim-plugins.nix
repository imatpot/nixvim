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
          rev = "b299d2689429b48afe48b1b294a6046487dacb6b";
          sha256 = "0g0avb88yda69psxa0hxif8x1zq2fllgy2zjpqfj0id13qqfymxa";
        };
        doCheck = false;
      };

      indentmini = super.vimUtils.buildVimPlugin {
        name = "indentmini.nvim";
        src = super.fetchFromGitHub {
          owner = "nvimdev";
          repo = "indentmini.nvim";
          rev = "38572ce5a7a064a5deb89d6d861b7c40fc929ab1";
          sha256 = "06i8i5dbp8p2g35sp6r8rcv52z0y7ww9rr0af8662cn5pcv03jjx";
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
          rev = "ea93521c0344fa2530c6f6da8b059d1b944ca550";
          sha256 = "0nv8mmqpzmy1in8fzc662r8d0d414ybyxgm5w6zgx7ryxiq5hmn5";
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

      fyler = super.vimUtils.buildVimPlugin {
        name = "fyler.nvim";
        src = super.fetchFromGitHub {
          owner = "A7Lavinraj";
          repo = "fyler.nvim";
          rev = "8fe34a34fdd307ee762a2099be90b259fce39d21";
          sha256 = "1r99y6fsvmv5ai7ynrpw4nsfj9y7za3xsanaiw7gxih89d5p0z5m";
        };
        doCheck = false;
      };

      cmp-dotenv = super.vimUtils.buildVimPlugin {
        name = "cmp-dotenv";
        src = super.fetchFromGitHub {
          owner = "SergioRibera";
          repo = "cmp-dotenv";
          rev = "4dd53aab60982f1f75848aec5e6214986263325e";
          sha256 = "0pkkxfwsmp2rn77x8jbsb1j0avjx813n5kp4q6f0v0rfmjxk538i";
        };
        doCheck = false;
      };
    };
}
