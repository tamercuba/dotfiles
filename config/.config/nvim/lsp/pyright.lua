local function get_python_executable()
	local venv_path = os.getenv("VIRTUAL_ENV")
	if venv_path then
		return venv_path .. "/bin/python"
	else
		return "python"
	end
end

return {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = {
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		"pyrightconfig.json",
	},
	settings = {
		python = {
			pythonPath = get_python_executable(),
			typeCheckingMode = "basic",
			analyzeUnannotatedFunctions = false,
			reportReturnType = true,
			diagnosticMode = "workspace",
			useLibraryCodeForTypes = true,
			autoImportCompletions = true,
			autoSearchPaths = true,
		},
	},
}
