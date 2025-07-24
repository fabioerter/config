return {
  "andythigpen/nvim-coverage",
  event = "BufReadPost",
  config = function()
    local uv = vim.loop

    -- Função para encontrar o coverage mais recente
    local function find_coverage_file()
      local pattern = "testes/.*/TestResults/.*/coverage.cobertura.xml"
      local handle = io.popen("find " .. pattern .. " -type f 2>/dev/null | head -n 1")
      if handle then
        local result = handle:read("*a")
        handle:close()
        result = result:gsub("%s+", "") -- limpa newline
        return result ~= "" and result or nil
      end
      return nil
    end

    require("coverage").setup({
        commands = true, -- create commands
        highlights = {
        -- customize highlight groups created by the plugin
        covered = { fg = "#C3E88D" },   -- supports style, fg, bg, sp (see :h highlight-gui)
        uncovered = { fg = "#F07178" },
        },
        signs = {
        -- use your own highlight groups or text markers
        covered = { hl = "CoverageCovered", text = "▎" },
        uncovered = { hl = "CoverageUncovered", text = "▎" },
        },
        summary = {
        -- customize the summary pop-up
        min_coverage = 100.0,      -- minimum coverage threshold (used for highlighting)
        },
        lang = {
                cs = {
                coverage_file = find_coverage_file(),
                cobertura = {
                -- configurações opcionais
                },
                },
        },
    })
  end,
}
