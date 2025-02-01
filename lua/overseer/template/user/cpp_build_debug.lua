return {
    name = "cmake build debug",
    builder = function()
        local root_dir = vim.fs.root(0, 'build')
        local build_dir = vim.fs.joinpath(root_dir, 'build')
        return {
            cmd = { "cmake" },
            args = {"--build", build_dir , "--config Debug"},
            components = { { "on_output_quickfix", open = true }, "default" },
        }
    end,
}