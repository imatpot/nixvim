self: super: {
  vimPlugins =
    super.vimPlugins
    // {
      search = super.vimUtils.buildVimPlugin rec {
        name = "search.nvim";
        src = super.fetchFromGitHub {
          owner = "FabianWirth";
          repo = name;
          rev = "7b8f2315d031be73e14bc2d82386dfac15952614";
          hash = "sha256-88rMEtHTk5jEQ00YleSr8x32Q3m0VFZdxSE2vQ+f0rM=";
        };
        doCheck = false;
      };

      kak-nvim = super.vimUtils.buildVimPlugin rec {
        name = "kak.nvim";
        src = super.fetchFromGitHub {
          owner = "mirlge";
          repo = name;
          rev = "d4d55034232209d1476902ea004c48e01e06aa2a";
          hash = "sha256-KkF6eh3LMOTDE87x/YB3E8pCNAptxgRkJ2v2e19gGEU=";
        };
        doCheck = false;
      };

      indentmini = super.vimUtils.buildVimPlugin rec {
        name = "indentmini.nvim";
        src = super.fetchFromGitHub {
          owner = "nvimdev";
          repo = name;
          rev = "59c2be5387e3a3308bb43f07e7e39fde0628bd4d";
          hash = "sha256-RtNPlILvlEyIFfDK8NTq8LPZR5vIl6uBxeE3vftUS6g=";
        };
        doCheck = false;
      };
    };
}
