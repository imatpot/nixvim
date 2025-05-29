{
  config,
  lib,
  ...
}:
lib.utils.modules.mkModule config true "debugging" {
  plugins = {
    dap = {
      enable = true;
      signs.dapBreakpoint = {
        text = "";
        texthl = "DiagnosticSignError";
      };
    };

    dap-ui.enable = true;
    dap-virtual-text.enable = true;

    cmp.settings.sources = [{name = "dap";}];
  };

  keymaps = [
    {
      key = "<Leader>db";
      action = "<CMD>lua require('dap').toggle_breakpoint()<CR>";
      options.desc = "(Debugger) Add breakpoint";
    }
    {
      key = "<Leader>ds";
      action = "<CMD>lua require('dap').continue()<CR>";
      options.desc = "(Debugger) Start / Continue";
    }
    {
      key = "<Leader>do";
      action = "<CMD>lua require('dap').step_over()<CR>";
      options.desc = "(Debugger) Step over";
    }
    {
      key = "<Leader>di";
      action = "<CMD>lua require('dap').step_into()<CR>";
      options.desc = "(Debugger) Step into";
    }
    {
      key = "<Leader>dO";
      action = "<CMD>lua require('dap').step_out()<CR>";
      options.desc = "(Debugger) Step out";
    }
    {
      key = "<Leader>dr";
      action = "<CMD>lua require('dap').repl.toggle()<CR>";
      options.desc = "(Debugger) REPL";
    }
    {
      key = "<Leader>dS";
      action = "<CMD>lua require('dap').close()<CR>";
      options.desc = "(Debugger) Stop";
    }
    {
      key = "<Leader>dd";
      action = "<CMD>lua require('dapui').toggle()<CR>";
      options.desc = "(Debugger) Toggle UI";
    }
  ];
}
