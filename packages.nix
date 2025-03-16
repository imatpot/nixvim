self: super: {
  vimPlugins =
    super.vimPlugins
    // {
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
    };
}
