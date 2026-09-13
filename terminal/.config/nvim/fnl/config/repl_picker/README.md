# REPL Picker

A snacks.nvim-based picker for starting project/module-specific REPLs in tmux.

## Usage

### Key Bindings

- `<localleader>mr` - Open the REPL picker
- `:ReplPicker` - Command to open the picker

### How It Works

1. Press `<localleader>mr` (or run `:ReplPicker`)
2. A snacks picker will appear showing all available REPLs
3. Select a module using:
   - Arrow keys or `j`/`k` to navigate
   - Type to filter/search modules
   - `<Enter>` to select
   - `<Esc>` to cancel
4. The REPL will start in a new tmux window within the "REPL" session
5. If the "REPL" session doesn't exist, it will be created automatically
6. When you exit the REPL, the tmux window closes automatically

## Configuration

### Adding More Projects

The picker uses a **modular configuration system**. REPL configurations are authored as `*.repl.fnl` files in the `repl_picker/` directory; nfnl compiles each one to a `*.repl.lua` file, which is what actually gets loaded at runtime. This allows you to:
- Keep company/proprietary configurations private (gitignored, both the `.fnl` source and the compiled `.lua`)
- Commit personal project configurations
- Organize configurations by project or company

#### Creating a New Configuration File

1. Create a new `*.repl.fnl` file in `~/.config/nvim/fnl/config/repl_picker/`
   - Example: `my_projects.repl.fnl`, `personal.repl.fnl`, `company_name.repl.fnl`
   - **Important**: File MUST end with `.repl.fnl` so nfnl compiles it to `*.repl.lua`, which is what gets loaded

2. The file should return a table with this structure:

```fennel
;; my_projects.repl.fnl
{"/path/to/your/project" {"Project REPL" {:command "lein repl" ; Command to run
                                          :cwd "/path/to/your/project"} ; Working directory
                          "Module A REPL" {:command "lein repl"
                                           :cwd "/path/to/your/project/modules/module_a"}}}
```

3. Save the file (or restart Neovim) - nfnl compiles it and the REPL picker loads it automatically!

#### Example Configuration

See `example.repl.fnl.example` in the `repl_picker/` directory for a complete example.

#### Keeping Configurations Private

To keep company-specific configurations out of version control:
1. Create a file like `company.repl.fnl`
2. Add both it and its compiled `company.repl.lua` counterpart to `.gitignore`
3. Commit your personal project configurations separately

### Customizing the Key Binding

Edit `~/.config/nvim/fnl/config/repl_picker/init.fnl` at the bottom where the keymap is registered:

```fennel
(vim.keymap.set :n :<your-preferred-keybinding> (fn [] (select-and-start-repl all-repls))
                {:desc "Open REPL picker" :noremap true :silent true})
```

### Project-Specific Configuration

The picker automatically detects the current project by looking for:
- `project.clj`
- `deps.edn`
- `.git`

It matches the found project root against the merged configuration loaded from all `*.repl.lua` files.

## Directory Structure

```
~/.config/nvim/fnl/config/repl_picker/
├── init.fnl                     # Main module source (auto-loads all configs)
├── README.md                    # This file
├── example.repl.fnl.example     # Example template
└── *.repl.fnl                   # Your REPL configurations (add to .gitignore if private)

~/.config/nvim/lua/config/repl_picker/
└── *.lua                        # Compiled output (nfnl-generated, do not edit by hand)
```

## File Naming Convention

**Important**: REPL configuration files MUST be named `*.repl.fnl`

- ✅ `personal.repl.fnl` - Will be compiled and loaded
- ✅ `my_projects.repl.fnl` - Will be compiled and loaded
- ✅ `company.repl.fnl` - Will be compiled and loaded
- ❌ `personal.fnl` - Will NOT be loaded
- ❌ `config.fnl` - Will NOT be loaded

This naming convention prevents accidental loading of utility files.

## Requirements

- Neovim with snacks.nvim installed (picker enabled)
- tmux (must be running inside a tmux session)
- Your REPL tool of choice (e.g., lein, clj, node, python, etc.)

## Troubleshooting

### "You must be inside a tmux session"
Make sure you're running Neovim inside a tmux session. Start tmux first:
```bash
tmux
nvim
```

### "snacks.nvim is not installed"
Install folke/snacks.nvim through your plugin manager.

### "No REPL configurations found for this project"
Either:
1. You're not in a recognized project directory
2. The project hasn't been configured in any `*.repl.lua` file in `repl_picker/`

### REPL doesn't start
Check that:
1. The command is correct (e.g., `lein repl`)
2. The working directory exists
3. You have the necessary dependencies installed

