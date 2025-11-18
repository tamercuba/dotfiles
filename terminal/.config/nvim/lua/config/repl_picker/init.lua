local M = {}

local function load_repl_configurations()
	local config_dir = vim.fn.stdpath("config") .. "/lua/config/repl_picker"
	local repl_configs = {}

	local glob_pattern = config_dir .. "/*.repl.lua"
	local files = vim.fn.glob(glob_pattern, false, true)

	for _, file in ipairs(files) do
		local filename = file:match("([^/]+)$")
		local success, result = pcall(dofile, file)
		if success and type(result) == "table" then
			repl_configs = vim.tbl_deep_extend("force", repl_configs, result)
		else
			vim.notify(
				string.format("Failed to load REPL config from %s: %s", filename, tostring(result)),
				vim.log.levels.WARN
			)
		end
	end

	return repl_configs
end

M.project_repls = load_repl_configurations()
local function find_project_root()
	local markers = { "project.clj", "deps.edn", ".git" }
	local current_file = vim.fn.expand("%:p:h")

	for _, marker in ipairs(markers) do
		local found = vim.fn.findfile(marker, current_file .. ";")
		if found ~= "" then
			return vim.fn.fnamemodify(found, ":p:h")
		end
	end

	return nil
end

local function get_current_project_repls()
	local project_root = find_project_root()

	if project_root and M.project_repls[project_root] then
		return M.project_repls[project_root], project_root
	end

	for root, repls in pairs(M.project_repls) do
		if project_root and project_root:find(root, 1, true) then
			return repls, root
		end
	end

	return nil, nil
end

local function start_repl_in_tmux(display_name, repl_config)
	local command = repl_config.command
	local cwd = repl_config.cwd
	local full_command = string.format("cd %s && %s", vim.fn.shellescape(cwd), command)

	local in_tmux = vim.fn.system("tmux display-message -p '#{session_name}' 2>/dev/null")
	if vim.v.shell_error ~= 0 then
		vim.notify("You must be inside a tmux session to use this feature", vim.log.levels.ERROR)
		return
	end

	local session_exists = vim.fn.system("tmux has-session -t REPL 2>/dev/null")
	local target_session = "REPL"

	if vim.v.shell_error ~= 0 then
		vim.fn.system("tmux new-session -d -s REPL")
		vim.notify("Created tmux session: REPL", vim.log.levels.INFO)
	end

	local window_name = display_name:gsub(" REPL$", "") -- Remove "REPL" suffix for cleaner name
	local tmux_cmd = string.format(
		"tmux new-window -t %s -n %s '%s'",
		vim.fn.shellescape(target_session),
		vim.fn.shellescape(window_name),
		full_command
	)

	vim.fn.system(tmux_cmd)

	if vim.v.shell_error == 0 then
		vim.notify(string.format("Started %s in tmux session 'REPL'", display_name), vim.log.levels.INFO)
	else
		vim.notify(string.format("Failed to start %s", display_name), vim.log.levels.ERROR)
	end
end

function M.select_and_start_repl()
	local repls, project_root = get_current_project_repls()

	if not repls then
		vim.notify("No REPL configurations found for this project", vim.log.levels.WARN)
		return
	end

	local has_telescope, telescope = pcall(require, "telescope.pickers")
	if not has_telescope then
		vim.notify("Telescope is not installed", vim.log.levels.ERROR)
		return
	end

	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local conf = require("telescope.config").values
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")

	local repl_list = {}
	for display_name, config in pairs(repls) do
		table.insert(repl_list, {
			display = display_name,
			config = config,
		})
	end

	table.sort(repl_list, function(a, b)
		return a.display < b.display
	end)

	pickers
		.new({}, {
			prompt_title = "REPL Picker",
			finder = finders.new_table({
				results = repl_list,
				entry_maker = function(entry)
					return {
						value = entry,
						display = entry.display,
						ordinal = entry.display,
					}
				end,
			}),
			sorter = conf.generic_sorter({}),
			layout_strategy = "center",
			layout_config = {
				height = 0.4, 
				width = 0.5,
				prompt_position = "top",
			},
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					if selection then
						start_repl_in_tmux(selection.value.display, selection.value.config)
					end
				end)
				return true
			end,
		})
		:find()
end

function M.setup(opts)
	opts = opts or {}

	if opts.project_repls then
		M.project_repls = vim.tbl_deep_extend("force", M.project_repls, opts.project_repls)
	end

	vim.api.nvim_create_user_command("ReplPicker", function()
		M.select_and_start_repl()
	end, { desc = "Open REPL picker to start a REPL in tmux" })

	if opts.keymap then
		vim.keymap.set("n", opts.keymap, M.select_and_start_repl, {
			desc = "Open REPL picker",
			noremap = true,
			silent = true,
		})
	end
end

M.setup({
	keymap = "<localleader>mr",
})

return M

