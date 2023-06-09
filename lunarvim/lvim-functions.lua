local M = {}

function M:rename_symbol()
    vim.ui.input(
        { prompt = "Rename to: " },
        function(input) vim.lsp.buf.rename(input) end
    )
end

return M
