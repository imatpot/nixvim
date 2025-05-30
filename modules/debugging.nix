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
        text = "󰏧";
        texthl = "DiagnosticSignError";
      };
    };

    dap-virtual-text.enable = true;

    dap-ui = {
      enable = true;

      settings = {
        controls.enabled = false;

        icons = {
          collapsed = "";
          expanded = "";
          current_frame = "";
        };
      };
    };

    cmp.settings.sources = [
      {
        name = "dap";
      }
    ];
  };

  keymaps = [
    {
      key = "<leader>db";
      action = "<CMD>DapToggleBreakpoint<CR>";
      options.desc = "Add breakpoint";
    }
    {
      key = "<leader>ds";
      action = "<CMD>DapContinue<CR>";
      options.desc = "Start / Continue";
    }
    {
      key = "<leader>do";
      action = "<CMD>DapStepOver<CR>";
      options.desc = "Step over";
    }
    {
      key = "<leader>di";
      action = "<CMD>DapStepInto<CR>";
      options.desc = "Step into";
    }
    {
      key = "<leader>dO";
      action = "<CMD>DapStepOut<CR>";
      options.desc = "Step out";
    }
    {
      key = "<leader>dr";
      action = "<CMD>DapToggleRepl<CR>";
      options.desc = "REPL";
    }
    {
      key = "<leader>dp";
      action = "<CMD>DapPause<CR>";
      options.desc = "Pause";
    }
    {
      key = "<leader>dq";
      action = "<CMD>DapTerminate<CR>";
      options.desc = "Stop";
    }
    {
      key = "<leader>dd";
      action = "<CMD>lua require('dapui').toggle()<CR>";
      options.desc = "Toggle Debugger UI";
    }
    {
      key = "<leader>de";
      options.desc = "Evaluate expression";

      # first eval() evaluates, second eval() focuses floating window
      action = "<CMD>lua require('dapui').eval(); require('dapui').eval()<CR>";
    }
  ];
}
