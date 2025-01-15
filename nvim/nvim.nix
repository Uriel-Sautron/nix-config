{ pkgs, ... }: {
  programs = {
    nixvim = {
      enable = true;
      opts = {
        number = true; # Show line numbers
        shiftwidth = 2; # Tab width should be 2
        completeopt = [ "menu" "menuone" "noselect" ];
      };
      plugins = {
        bufferline = {
          enable = true;
        };

        neo-tree = {
          enable = true;
          enableGitStatus = true;
          enableModifiedMarkers = true;
          enableRefreshOnWrite = true;
          closeIfLastWindow = true;
          buffers = {
            bindToCwd = false;
            followCurrentFile = {
              enabled = true;
            };
          };
        };

        undotree = {
          enable = true;
          settings = {
            autoOpenDiff = true;
            focusOnToggle = true;
          };
        };

        treesitter = {
          enable = true;
          nixvimInjections = true;
          settings = {
            highlight.enable = true;
            indent.enable = true;
          };
          folding = false;
        };

        startify = {
          enable = true;
          settings = {
            custom_header = [
              ""
              "     ███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗"
              "     ████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║"
              "     ██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║"
              "     ██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║"
              "     ██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║"
              "     ╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝"
            ];

            # When opening a file or bookmark, change to its directory.
            change_to_dir = false;
            # By default, the fortune header uses ASCII characters, because they work for everyone.
            # If you set this option to 1 and your 'encoding' is "utf-8", Unicode box-drawing characters will
            # be used instead.
            use_unicode = true;
            lists = [{ type = "dir"; }];
            files_number = 30;
            skiplist = [
              "flake.lock"
            ];
          };
        };

        none-ls = {
          enable = true;
          settings = {
            cmd = [ "bash -c nvim" ];
            debug = true;
          };
          sources = {
            code_actions = {
              statix.enable = true;
              gitsigns.enable = true;
            };
            diagnostics = {
              statix.enable = true;
              deadnix.enable = true;
              pylint.enable = true;
              checkstyle.enable = true;
            };
            formatting = {
              alejandra.enable = true;
              stylua.enable = true;
              shfmt.enable = true;
              nixpkgs_fmt.enable = true;
              prettier = {
                enable = true;
                disableTsServerFormatter = true;
              };
              black = {
                enable = true;
                settings = ''
                  {
                    extra_args = { "--fast" },
                  }
                '';
              };
            };
            completion = {
              luasnip.enable = true;
              spell.enable = true;
            };
          };
        };

        copilot-vim = {
          enable = true;
        };

        lsp = {
          enable = true;
          servers = {
            # Average webdev LSPs
            ts_ls.enable = true; # TS/JS
            eslint.enable = true; # ESLint
            cssls.enable = true; # CSS
            tailwindcss.enable = true; # TailwindCSS
            html.enable = true; # HTML
            svelte.enable = false; # Svelte
            vuels.enable = false; # Vue
            pyright.enable = true; # Python
            marksman.enable = true; # Markdown
            nil_ls.enable = true; # Nix
            dockerls.enable = true; # Docker
            bashls.enable = true; # Bash
            yamlls.enable = true; # YAML
            sqls.enable = true; # SQL
            emmet_ls.enable = true; # Emmet

            lua_ls = {
              # Lua
              enable = true;
              settings.telemetry.enable = false;
            };

            # Rust
            rust_analyzer = {
              enable = true;
              installRustc = true;
              installCargo = true;
            };
          };
        };

        lsp-format = {
          enable = true;
        };

        lint = {
          enable = true;
          lintersByFt = {
            text = [ "vale" ];
            eslint = [ "eslint" ];
            json = [ "jsonlint" ];
            markdown = [ "vale" ];
            rst = [ "vale" ];
            ruby = [ "ruby" ];
            janet = [ "janet" ];
            inko = [ "inko" ];
            clojure = [ "clj-kondo" ];
            dockerfile = [ "hadolint" ];
            terraform = [ "tflint" ];
          };
        };

        luasnip.enable = true;

        lspkind = {
          enable = true;
          cmp = {
            enable = true;
            menu = {
              nvim_lsp = "[LSP]";
              nvim_lua = "[api]";
              path = "[path]";
              luasnip = "[snip]";
              buffer = "[buffer]";
              neorg = "[neorg]";
            };
          };
        };

        telescope = {
          enable = true;
          keymaps = {
            # Find files using Telescope command-line sugar.
            "<leader>ff" = "find_files";
            "<leader>fg" = "live_grep";
            "<leader>b" = "buffers";
            "<leader>fh" = "help_tags";
            "<leader>fd" = "diagnostics";

            # FZF like bindings
            "<C-p>" = "git_files";
            "<leader>p" = "oldfiles";
            "<C-f>" = "live_grep";
          };
          settings.defaults = {
            file_ignore_patterns = [
              "^.git/"
              "^.mypy_cache/"
              "^__pycache__/"
              "^output/"
              "^data/"
              "%.ipynb"
            ];
            set_env.COLORTERM = "truecolor";
          };
        };

        comment = {
          enable = true;

          settings = {
            opleader.line = "<C-b>";
            toggler.line = "<C-b>";
          };
        };

        cmp = {
          enable = true;
          settings = {
            snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
            mapping = {
              "<C-d>" = "cmp.mapping.scroll_docs(-4)";
              "<C-f>" = "cmp.mapping.scroll_docs(4)";
              "<C-Space>" = "cmp.mapping.complete()";
              "<C-e>" = "cmp.mapping.close()";
              "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
              "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
              "<CR>" = "cmp.mapping.confirm({ select = true })";
            };
            sources = [
              { name = "path"; }
              { name = "nvim_lsp"; }
              { name = "luasnip"; }
              {
                name = "buffer";
                # Words from other open buffers can also be suggested.
                option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
              }
              { name = "neorg"; }
            ];
          };
        };

        markdown-preview = {
          enable = true;
          settings = {
            auto_close = 0;
            theme = "dark";
          };
        };

        colorizer = {
          enable = true;
          package = pkgs.vimPlugins.nvim-colorizer-lua;
          settings = {
            user_default_options = {
              AARRGGBB = true;
              RGB = true;
              RRGGBB = true;
              RRGGBBAA = true;
              css = true;
              css_fn = true;
              hsl_fn = true;
              mode = "background";
              names = true;
              rgb_fn = true;
              tailwind = true;
            };
          };
        };

        web-devicons.enable = true;
      };

      files."after/ftplugin/markdown.lua".keymaps = [
        {
          mode = "n";
          key = "<leader>m";
          action = ":MarkdownPreview<cr>";
        }
      ];
      colorschemes.everforest = {
        enable = true;
      };
    };
  };
}
