return {
    name = "cmake build debug",
    builder = function()
        local root_dir = vim.fs.root(0, 'build')
        local build_dir = vim.fs.joinpath(root_dir, 'build')
        local target = "all"
        vim.ui.input(
            {
                prompt = "Which target you want to build? (Empty is default): ",
            }, function(selected)
                if selected and selected ~= "" then
                    target = selected
                end
            end
        )
        return {
            cmd = { "cmake" },
            args = {"--build", build_dir, "--config Debug", "--target", target},
            components = { "default" },
        }
    end,
}