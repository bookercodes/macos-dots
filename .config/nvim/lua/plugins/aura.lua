return {
  {
    "baliestri/aura-theme",
    lazy = false,
    priority = 1000,
    config = function()
      -- Safely load the Aura Dark theme
      local ok, _ = pcall(vim.cmd, [[colorscheme aura-dark]])
      if not ok then
        vim.notify("Aura theme not loaded yet. Run :Lazy sync and restart.", vim.log.levels.WARN)
      end

      -- Other available variants:
      -- vim.cmd([[colorscheme aura-dark-soft]])
      -- vim.cmd([[colorscheme aura-soft-dark]])
    end,
  },
}
