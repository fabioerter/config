return {
  "LazyVim/LazyVim",
  init = function()
    if vim.fn.has("wsl") == 1 then
      vim.g.clipboard = {
        name = "WslClipboard",
        copy = {
                ["+"] = "clip.exe",
                ["*"] = "clip.exe",
        },
        paste = {
                ["+"] = [[powershell.exe -nologo -noprofile -command Get-Clipboard | tr -d '\r']],
                ["*"] = [[powershell.exe -nologo -noprofile -command Get-Clipboard | tr -d '\r']]
        },
        cache_enabled = 0,
      }

      -- Redefine 'y' para copiar diretamente para o clipboard do sistema
        vim.keymap.set("n", "y", '"+y', { noremap = true, silent = true })
        vim.keymap.set("v", "y", '"+y', { noremap = true, silent = true })
    end
  end,
}
