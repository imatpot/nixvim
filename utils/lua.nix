{lib, ...}: {
  mkExpr = expr:
    lib.nixvim.mkRaw ''
      (function()
        return ${expr}
      end)()
    '';
}
