Terminal = require("toggleterm.terminal").Terminal

GitUi = Terminal:new({
  cmd = "${lib.getExe pkgs.gitui}",
  direction = "float",
  float_opts = {
    border = "curved",
  },
  hidden = true,
})

function ToggleGitUi()
  GitUi:toggle()
end
