return {
  "neovim/nvim-lspconfig",
  version = "0.1.9",
  dependencies = {
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/nvim-cmp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "b0o/schemastore.nvim",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local luasnip = require("luasnip")
    local dnscUtils = require("dnsc.utils")
    local lspUtils = require("lspconfig.util")
    local cmp = require("cmp")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    local servers = {
      "eslint",
      "angularls",
      "ts_ls",
      "lua_ls",
      "jsonls",
      "html",
      "cssls",
      "tailwindcss",
      "gopls",
      "astro",
      "tinymist",
      "ols",
    }

    require("mason").setup()
    -- Automatic Server Installation with Mason
    require("mason-lspconfig").setup({
      ensure_installed = servers,
      automatic_installation = true,
    })

    -- LANGUAGE SERVERS
    -- Lua
    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          telemetry = {
            enable = false,
          },
        },
      },
    })

    -- Typescript
    lspconfig.tsserver.setup({
      capabilities = capabilities,
      root_dir = lspUtils.root_pattern("package.json"),
      init_options = {
        preferences = {
          importModuleSpecifierPreference = "relative",
          importModuleSpecifierEnding = "minimal",
        },
      },
      handlers = {
        ["textDocument/definition"] = function(err, result, method, ...)
          if vim.tbl_islist(result) and #result > 1 then
            local filtered_result = dnscUtils.filter(result, dnscUtils.filterReactDTS)
            return vim.lsp.handlers["textDocument/definition"](err, filtered_result, method, ...)
          end

          vim.lsp.handlers["textDocument/definition"](err, result, method, ...)
        end,
      },
    })

    -- JSON
    lspconfig.jsonls.setup({
      capabilities = capabilities,
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    })

    -- HTML
    lspconfig.html.setup({
      capabilities = capabilities,
    })

    -- Astro
    lspconfig.astro.setup({})

    -- Tailwind
    lspconfig.tailwindcss.setup({})

    -- Typst
    lspconfig.tinymist.setup({
      single_file_support = true,
      root_dir = function()
        return vim.fn.getcwd()
      end,
      settings = {},
    })

    -- CSS
    lspconfig.cssls.setup({})

    -- Angular
    lspconfig.angularls.setup({})

    -- ESLint
    lspconfig.eslint.setup({})

    -- Go
    lspconfig.gopls.setup({
      capabilities = capabilities,
    })

    -- Run gofmt + goimports on save
    local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.go",
      callback = function()
        require("go.format").goimports()
      end,
      group = format_sync_grp,
    })

    -- Odin
    lspconfig.ols.setup({})

    -- LSP Keybindings
    -- Global mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
    vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<space>f", function()
          vim.lsp.buf.format({ async = true })
        end, opts)
      end,
    })

    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      formatting = {
        format = function(entry, vim_item)
          -- Kind icons
          vim_item.kind = string.format("%s ", vim_item.kind) -- This concatenates the icons with the name of the item kind
          -- Source
          vim_item.menu = ({
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            luasnip = "[Snip]",
            nvim_lua = "[Lua]",
          })[entry.source.name]
          return vim_item
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            if luasnip.expandable() then
              luasnip.expand()
            else
              cmp.confirm({
                select = true,
              })
            end
          else
            fallback()
          end
        end),

        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp", keyword_length = 1 },
        { name = "path" },
        { name = "buffer", keyword_length = 3 },
        { name = "luasnip" }, -- For luasnip users.
        { name = "render-markdown" },
      }),
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })

    -- Set up vim-dadbod completions
    cmp.setup.filetype({ "sql", "mysql", "psql" }, {
      sources = {
        { name = "vim-dadbod-completion" },
        { name = "buffer" },
      },
    })

    -- Set up org mode
    cmp.setup.filetype({ "org" }, {
      sources = {
        { name = "orgmode" },
      },
    })
  end,
}
