-- This file configures the Go debugger, Delve, for nvim-dap.
-- It is designed to be placed in the lua/custom directory of a kickstart.nvim setup.

return {
  -- Core DAP client
  "mfussenegger/nvim-dap",
  dependencies = {
    -- UI for nvim-dap
    "rcarriga/nvim-dap-ui",
    -- Go-specific configurations for nvim-dap
    "leoluz/nvim-dap-go",
    -- Virtual text for in-line variable inspection
    "theHamsta/nvim-dap-virtual-text",
    -- Dependency for nvim-dap-ui
    "nvim-neotest/nvim-nio",
    -- Installs debuggers
    "williamboman/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",
  },
  config = function()
    local dap = require "dap"
    local dapui = require "dapui"
    local dapgo = require "dap-go"

    -- Setup nvim-dap-ui
    dapui.setup {
      layouts = {
        {
          elements = {
            -- Adjust layout to your liking
            { id = "watches", size = 0.25 },
            { id = "scopes", size = 0.25 },
            { id = "breakpoints", size = 0.25 },
            { id = "stack", size = 0.25 },
          },
          size = 0.4,
          position = "right",
        },
        {
          elements = {
            "repl",
            "console",
          },
          size = 0.3,
          position = "bottom",
        },
      },
      floating = {
        border = "rounded",
      },
    }

    -- Setup nvim-dap-go
    dapgo.setup {
      -- Delve-specific settings
      delve = {
        -- Path to your dlv binary (optional, if dlv is in your PATH)
        path = "dlv",
      },
    }

    -- Setup Mason to install Delve automatically
    require("mason-nvim-dap").setup {
      ensure_installed = { "go" },
      automatic_installation = true,
      handlers = {},
    }

    -- Set up some common keymaps
    vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP: Continue/Start" })
    vim.keymap.set("n", "<F6>", dap.step_over, { desc = "DAP: Step Over" })
    vim.keymap.set("n", "<F7>", dap.step_into, { desc = "DAP: Step Into" })
    vim.keymap.set("n", "<F8>", dap.step_out, { desc = "DAP: Step Out" })
    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>dpl", function() dapui.open() end, { desc = "DAP: Toggle UI" })
    vim.keymap.set("n", "<leader>drt", dap.repl.toggle, { desc = "DAP: Toggle REPL" })
    vim.keymap.set("n", "<leader>dK", function() require("dap.ui.widgets").hover() end, { desc = "DAP: Hover" })

    -- Automatically open and close the UI when a debug session starts and ends
    dap.listeners.after.event_initialized.dapui_config = function() dapui.open() end
    dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
    dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
  end,
}
