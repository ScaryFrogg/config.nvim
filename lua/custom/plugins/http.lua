return {
  "heilgar/nvim-http-client",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp", -- Optional but recommended for enhanced autocompletion
    "nvim-telescope/telescope.nvim", -- Optional for better environment selection
  },
  event = "VeryLazy",
  ft = { "http", "rest" },
  config = function()
    require("http_client").setup {
      -- Default configuration (works out of the box)
      default_env_file = ".env.json",
      request_timeout = 30000,
      split_direction = "right",
      create_keybindings = true,
      --user_agent = "heilgar/nvim-http-client", -- Custom User-Agent header

      -- Profiling (timing metrics for requests)
      profiling = {
        enabled = true,
        show_in_response = true,
        detailed_metrics = true,
      },

      keybindings = {
        select_env_file = "<leader>Hf",
        set_env = "<leader>He",
        run_request = "<leader>Hr",
        stop_request = "<leader>Hx",
        toggle_verbose = "<leader>Hv",
        toggle_profiling = "<leader>Hp",
        dry_run = "<leader>Hd",
        copy_curl = "<leader>Hc",
        save_response = "<leader>Hs",
        set_project_root = "<leader>Hg",
        get_project_root = "<leader>Hgg",
      },
    }

    -- Set up Telescope integration if available
    if pcall(require, "telescope") then require("telescope").load_extension "http_client" end
  end,
}
