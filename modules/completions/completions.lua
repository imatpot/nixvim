local cmp = require("cmp")
local utf8 = require("lua-utf8")

local blink_config = {}

blink_config.has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

blink_config.colorize_text = function(context)
    return require("colorful-menu").blink_components_text(context)
end

blink_config.colorize_highlights = function(context)
    return require("colorful-menu").blink_components_highlight(context)
end

blink_config.use_kind_name = function(name)
    return function(context, items)
        for _, item in ipairs(items) do
            item.kind_name = name
        end

        return items
    end
end

blink_config.has_selection = function()
    return require('blink.cmp.completion.list').get_selected_item() ~= nil
end

blink_config.cancel = function(blink)
    if blink.hide() then
        vim.cmd.stopinsert()
    else
        -- https://github.com/Saghen/blink.cmp/issues/547#issuecomment-2593493560
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-c>", true, true, true), "n", true)
    end

    return true
end

blink_config.indent_if_no_words_before = function(blink)
    if not blink_config.has_words_before() then
        local success, intellitab = pcall(require, 'intellitab')
        if success then
            intellitab.indent()
            return true
        end
    end
end

-- +-------------------+ --
-- | UTF-8 COMPLETIONS | --
-- +-------------------+ --

local unicode = {
    table = {},       -- populated in autocommand
    completions = {}, -- populated in autocommand
}

unicode.from_hex = function(hex)
    local code = tonumber(hex, 16)
    return utf8.char(code)
end

unicode.is_control_char = function(hex)
    local code = tonumber(hex, 16)

    return code == 0x7F
        or (code >= 0x00 and code <= 0x1F)
        or (code >= 0x80 and code <= 0x9F)
end

unicode.populate_completions = function()
    vim.defer_fn(function()
        local unicode_file = vim.fn.stdpath('data') .. '/site/unicode/UnicodeData.txt'

        local function should_update_unicode_table()
            local one_month = 30 * 24 * 60 * 60

            local stat = vim.loop.fs_stat(unicode_file)
            if stat then
                local age = os.time() - stat.mtime.sec
                return age > one_month
            end

            return true
        end

        if should_update_unicode_table() then
            vim.cmd("silent! UnicodeDownload!")
        end

        local file = io.open(unicode_file, "r")
        if file then
            local contents = file:read("*a")
            file:close()
            unicode.table = vim.tbl_filter(function(line)
                return line ~= ""
            end, vim.split(contents, "\n"))
        end

        for _, line in ipairs(unicode.table) do
            local sections = vim.split(line, ";")
            local char = unicode.from_hex(sections[1]):gsub("^%s+", ""):gsub("%s+$", ""):gsub("\n", "")
            local hex = "U+" .. sections[1]:gsub("^%s+", ""):gsub("%s+$", ""):gsub("\n", "")
            local name = sections[2]:gsub("^%s+", ""):gsub("%s+$", ""):gsub("\n", "")

            if char and name and not unicode.is_control_char(sections[1]) then
                table.insert(unicode.completions, {
                    word = char,
                    abbr = char,
                    label = char,
                    insertText = char,
                    filterText = char .. " " .. hex .. " " .. name,
                    kind = cmp.lsp.CompletionItemKind.Text,
                    documentation = {
                        kind = "markdown",
                        value = "**" .. hex .. "** *" .. name .. "*",
                    },
                })
            end
        end
    end, 1000)
end

cmp.register_source('unicode', {
    complete = function(_, request, callback)
        callback({ items = unicode.completions, isIncomplete = false })
    end,
})
