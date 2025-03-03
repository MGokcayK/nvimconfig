local overseer = require("overseer")

overseer.setup({
    templates = { "builtin", "user.cpp_build_debug", "user.cpp_build_relwithdebinfo", "user.cpp_build_release" }
})

local function get_template_names()
    local templates = {}
  
    -- Built-in templates
    local builtin_templates = {
      "shell",
    }
    vim.list_extend(templates, builtin_templates)
  
    -- Load user templates
    local user_template_path = vim.fn.stdpath("config") .. "/lua/overseer/template/user/"
    local pattern = user_template_path .. "*.lua"
    
    local files = vim.fn.glob(pattern, true, true)
    
    if files and #files > 0 then
        for _, file in ipairs(files) do
            local module_name = "overseer.template.user." .. file:match("([^/\\]+)%.lua$")
            local ok, template = pcall(require, module_name)
            if ok and template and template.name then
                table.insert(templates, template.name)
            else
                vim.notify("Failed to load " .. module_name .. " Error:" .. vim.inspect(template), "error")
            end
        end
    else
      vim.notify("No user template files found.", "error")
    end
  
    return templates
end
  
-- Prompt user for template selection
local function prompt_for_template()
    local templates = get_template_names()

    local message = "Available Overseer Templates:\n"
    for i, name in ipairs(templates) do
        message = message .. string.format("%d. %s\n", i, name)
    end
    message = message .. "Enter template number or name: "

    vim.ui.input({ prompt = message }, function(input)
        if not input then
            vim.notify("No template selected.", "warn")
            return
        end

        local selected_template
        if tonumber(input) then
            local index = tonumber(input)
            if index >= 1 and index <= #templates then
                selected_template = templates[index]
            end
        else
            for _, name in ipairs(templates) do
                if name == input then
                    selected_template = name
                    break
                end
            end
        end

        if selected_template then
            overseer.run_template({ name = selected_template })
            vim.notify("Running template: " .. selected_template, "info")
        else
            vim.notify("Invalid template selection: " .. input, "error")
        end
    end)
end


vim.api.nvim_create_user_command("OverseerGRun", function()
    prompt_for_template()
end, {})