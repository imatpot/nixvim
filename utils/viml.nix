{lib, ...}: {
  fromLua = str: ''
    lua << trim EOF
      ${str}
    EOF
  '';

  join = lib.concatStringsSep " | " <| lib.filter (line: line != "") <| lib.splitString "\n";
}
