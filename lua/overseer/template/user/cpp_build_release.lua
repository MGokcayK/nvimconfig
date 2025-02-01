return {
    name = "cmake build release",
    builder = function()
        local root_dir = vim.fs.root(0, 'build')
        local build_dir = vim.fs.joinpath(root_dir, 'build')
        return {
            cmd = { "cmake" },
            args = {"--build", build_dir , "--config Release"},
            components = { { "on_output_quickfix", open = true }, "default" },
        }
    end,
}