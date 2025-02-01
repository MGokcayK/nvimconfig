require("overseer").setup({
    templates = { "builtin", "user.cpp_build_debug", "user.cpp_build_relwithdebinfo", "user.cpp_build_release", "user.cpp_build_clean" }
})