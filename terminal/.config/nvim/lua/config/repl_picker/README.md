# REPL Picker

A Telescope-based picker for starting project/module-specific REPLs in tmux.

## Usage

### Key Bindings

- `<localleader>mr` - Open the REPL picker
- `:ReplPicker` - Command to open the picker

### How It Works

1. Press `<localleader>mr` (or run `:ReplPicker`)
2. A Telescope picker will appear showing all available REPLs
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

The picker uses a **modular configuration system**. REPL configurations are loaded from `*.repl.lua` files in the `repl_picker/` directory. This allows you to:
- Keep company/proprietary configurations private (gitignored)
- Commit personal project configurations
- Organize configurations by project or company

#### Creating a New Configuration File

1. Create a new `*.repl.lua` file in `~/.config/nvim/lua/config/repl_picker/`
   - Example: `my_projects.repl.lua`, `personal.repl.lua`, `company_name.repl.lua`
   - **Important**: File MUST end with `.repl.lua` to be automatically loaded

2. The file should return a table with this structure:

```lua
-- my_projects.repl.lua
return {
  ["/path/to/your/project"] = {
    ["Project REPL"] = {
      command = "lein repl",  -- Command to run
      cwd = "/path/to/your/project",  -- Working directory
    },
    ["Module A REPL"] = {
      command = "lein repl",
      cwd = "/path/to/your/project/modules/module_a",
    },
  },
}
```

3. Restart Neovim or reload config - the file will be automatically loaded!

#### Example Configuration

See `example.repl.lua.example` in the `repl_picker/` directory for a complete example.

#### Keeping Configurations Private

To keep company-specific configurations out of version control:
1. Create a file like `company.repl.lua`
2. Add it to `.gitignore`
3. Commit your personal project configurations separately

### Customizing the Key Binding

Edit `~/.config/nvim/lua/config/repl_picker/init.lua` at the bottom where auto-setup is called:

```lua
-- Auto-setup with default configuration
M.setup({
  keymap = "<your-preferred-keybinding>",
})
```

### Project-Specific Configuration

The picker automatically detects the current project by looking for:
- `project.clj`
- `deps.edn`
- `.git`

It matches the found project root against configured projects in `M.project_repls`.

## Directory Structure

```
~/.config/nvim/lua/config/repl_picker/
├── init.lua                     # Main module (auto-loads all configs)
├── README.md                    # This file
├── example.repl.lua.example     # Example template
└── *.repl.lua                   # Your REPL configurations (add to .gitignore if private)
```

## File Naming Convention

**Important**: REPL configuration files MUST be named `*.repl.lua`

- ✅ `personal.repl.lua` - Will be loaded
- ✅ `my_projects.repl.lua` - Will be loaded
- ✅ `company.repl.lua` - Will be loaded
- ❌ `personal.lua` - Will NOT be loaded
- ❌ `config.lua` - Will NOT be loaded

This naming convention prevents accidental loading of utility files.

## Requirements

- Neovim with Telescope installed
- tmux (must be running inside a tmux session)
- Your REPL tool of choice (e.g., lein, clj, node, python, etc.)

## Troubleshooting

### "You must be inside a tmux session"
Make sure you're running Neovim inside a tmux session. Start tmux first:
```bash
tmux
nvim
```

### "Telescope is not installed"
Install Telescope.nvim through your plugin manager.

### "No REPL configurations found for this project"
Either:
1. You're not in a recognized project directory
2. The project hasn't been configured in any `*.repl.lua` file in `repl_picker/`

### REPL doesn't start
Check that:
1. The command is correct (e.g., `lein repl`)
2. The working directory exists
3. You have the necessary dependencies installed

