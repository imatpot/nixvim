local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")
local colorful_menu = require("colorful-menu")

local utf8 = require("lua-utf8")

function ExpandSnippet(args)
    luasnip.lsp_expand(args.body)
end

function FormatCompletion(entry, vim_item)
    local highlight = colorful_menu.cmp_highlights(entry)

    if highlight ~= nil then
        vim_item.abbr_hl_group = highlight.highlights
        vim_item.abbr = highlight.text
    end

    local kind = lspkind.cmp_format({
        mode = "symbol_text",
        maxwidth = 50
    })(entry, vim.deepcopy(vim_item))

    local strings = vim.split(kind.kind, "%s", { trimempty = true })
    local icon = strings[1] or ""
    local description = strings[2] or ""
    local description_delim = ""

    if description ~= "" then
        description_delim = "."
    end

    if entry.source.name == "rg" then
        icon = "";
    end

    if entry.source.name == "luasnip" then
        icon = "";
    end

    if entry.source.name == "calc" then
        icon = "";
    end

    if entry.source.name == "unicode" then
        icon = "󰻐";
    end

    if entry.source.name == "copilot" then
        icon = "";
    end

    vim_item.kind = " " .. icon .. " "
    vim_item.menu = "    " .. entry.source.name .. description_delim .. description

    return vim_item
end

function CopilotPriority(a, b)
    local a_copilot = a.source.name == "copilot"
    local b_copilot = b.source.name == "copilot"
    if a_copilot and not b_copilot then
        return true
    elseif not a_copilot and b_copilot then
        return false
    end
end

function UnicodePriority(a, b)
    local a_unicode = a.source.name == "unicode"
    local b_unicode = b.source.name == "unicode"
    if a_unicode and b_unicode then
        local a_code = tonumber(a.filter_text:match("U%+(%x+)"), 16)
        local b_code = tonumber(b.filter_text:match("U%+(%x+)"), 16)
        return a_code < b_code
    end
end

function ToggleCompletion(fallback)
    if cmp.visible() then
        cmp.close()
    else
        cmp.complete()
    end
end

function SelectNextCompletion(fallback)
    if not cmp.visible() then
        fallback()
    elseif cmp.visible() then
        cmp.select_next_item()
    elseif not cmp.select_next_item() and vim.bo.buftype ~= 'prompt' then
        cmp.complete()
    else
        fallback()
    end
end

function SelectPreviousCompletion(fallback)
    if not cmp.visible() then
        fallback()
    elseif cmp.visible() then
        cmp.select_prev_item()
    elseif not cmp.select_next_item() and vim.bo.buftype ~= 'prompt' then
        cmp.complete()
    else
        fallback()
    end
end

function ConfirmCompletionInsert(fallback)
    if cmp.visible() and cmp.get_active_entry() then
        if luasnip.expandable() then
            luasnip.expand()
        else
            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
        end
    else
        fallback()
    end
end

function AbortCompletion(fallback)
    if cmp.visible() and cmp.get_active_entry() then
        cmp.abort()
    else
        fallback()
    end
end

-- +-------------------+ --
-- | UTF-8 COMPLETIONS | --
-- +-------------------+ --

UnicodeTable = {}       -- populated in autocommand
UnicodeCompletions = {} -- populated in autocommand

function Utf8Character(hex)
    local code = tonumber(hex, 16)
    return utf8.char(code)
end

function IsUtf8ControlChar(hex)
    local code = tonumber(hex, 16)

    return code == 0x7F
        or (code >= 0x00 and code <= 0x1F)
        or (code >= 0x80 and code <= 0x9F)
end

cmp.register_source('unicode', {
    complete = function(_, _, callback)
        callback({ items = UnicodeCompletions, isIncomplete = false })
    end
})

function PopulateUnicodeCompletions()
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
            UnicodeTable = vim.tbl_filter(function(line)
                return line ~= ""
            end, vim.split(contents, "\n"))
        end

        for _, line in ipairs(UnicodeTable) do
            local sections = vim.split(line, ";")
            local char = Utf8Character(sections[1])
            local hex = "U+" .. sections[1]
            local name = sections[2]

            if char and name and not IsUtf8ControlChar(sections[1]) then
                table.insert(UnicodeCompletions, {
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
