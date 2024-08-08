-- Set the filetype for .h files to objc, for some reason vim detects .h as cpp
vim.cmd 'autocmd BufNewFile,BufRead *.h setfiletype objc'

return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = {}
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        python = { 'black' },
        c = { 'astyle' },
        objc = { 'astyle' },
        cpp = { 'astyle' },

        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
      },
      formatters = {
        astyle = {
          prepend_args = { '--style=allman', '--align-pointer=type', '--unpad-paren', '--align-reference=type', '--pad-header' },
        },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
