{lib, ...}: {
  luaToViml = s: ''
    lua << trim EOF
      ${s}
    EOF
  '';

  joinViml = s:
    lib.concatStringsSep " | "
    (lib.filter (line: line != "") (lib.splitString "\n" s));
}
