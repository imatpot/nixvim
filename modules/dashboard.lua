function RunCommand(command)
  local handle = assert(io.popen(command, "r"))
  local output = assert(handle:read("*a"))

  handle:close()

  return output:gsub("^(\n+)", ""):gsub("(\n+)$", "")
end

function RemoveAnsiCodes(str)
  return RunCommand("printf '" .. str .. "' | ansi2txt")
end

function GetRandomPokemon(shiny_rate)
  local generate_shiny = math.random() < (shiny_rate or -1) --> use krabby's default if unset
  local pokemon_command = "krabby random --no-title"

  if generate_shiny then
    pokemon_command = pokemon_command .. " --shiny"
  end

  return RunCommand(pokemon_command)
end

function GetPokemonSection()
  local utf8 = require("lua-utf8")

  local pokemon = GetRandomPokemon(0.01)
  local lines = vim.split(pokemon, "\n")
  local height = #lines
  local width = 0

  for _, line in ipairs(lines) do
    local clean_line = RemoveAnsiCodes(line)
    local line_length = utf8.len(clean_line)
    if line_length > width then
      width = line_length or 0
    end
  end

  local pimary = FindPrimaryColor(pokemon)
  local r, g, b = pimary.r, pimary.g, pimary.b
  local hex = string.format("#%02x%02x%02x", r, g, b)

  vim.api.nvim_set_hl(0, "SnacksDashboardIcon", { fg = hex })

  -- FIXME: https://github.com/folke/snacks.nvim/issues/1642
  -- local renderer = "printf '" .. pokemon .. "'"
  local renderer = table.concat({
    "while IFS= read -r line; do",
    "  pad_width=$(( ($(tput cols) - " .. width .. " ) / 2 ));",
    "  indent=$(printf '%*s' $pad_width \"\");",
    '  printf \'%s%s\\n\' "$indent" "$line";',
    "done <<'EOF'",
    pokemon,
    "EOF",
  }, "\n")

  return {
    section = "terminal",
    cmd = renderer,
    height = height,

    -- FIXME: https://github.com/folke/snacks.nvim/issues/1642
    -- width = width,
    -- align = "center",
  }
end

function FindPrimaryColor(str)
  local color_counts = {}

  for code in str:gmatch("\27%[(.-)m") do
    local parts = {}

    for part in code:gmatch("[^;]+") do
      parts[#parts + 1] = part
    end

    if #parts >= 5 and (parts[1] == "38" or parts[1] == "48") and parts[2] == "2" then
      local r = tonumber(parts[3])
      local g = tonumber(parts[4])
      local b = tonumber(parts[5])

      if r and g and b then
        local color_key = string.format("%d,%d,%d", r, g, b)
        color_counts[color_key] = (color_counts[color_key] or 0) + 1
      end
    end
  end

  local best_color = {
    chroma = 0,
    count = 0,
    luminance = 0.333,
    score = -1,
    value = {
      r = 255,
      g = 255,
      b = 255,
    },
  }

  for color_key, count in pairs(color_counts) do
    local r, g, b = color_key:match("(%d+),(%d+),(%d+)")
    r, g, b = tonumber(r), tonumber(g), tonumber(b)

    if r and g and b then
      local max = math.max(r, g, b)
      local min = math.min(r, g, b)
      local avg = (r + g + b) / 3

      -- https://www.w3.org/WAI/GL/wiki/Relative_luminance
      local luminance = (0.2126 * r + 0.7152 * g + 0.0722 * b) / 255

      local chroma = (max - min) / 255
      local grayness = (math.abs(avg - r) + math.abs(avg - g) + math.abs(avg - b)) / (255 * 3)

      local score = chroma + luminance - (grayness * 0.8)

      local better_score = score > best_color.score
      local equal_score = score == best_color.score
      local better_luminance = luminance > best_color.luminance
      local equal_luminance = luminance == best_color.luminance
      local better_count = count > best_color.count

      if better_score or (equal_score and (better_luminance or (equal_luminance and better_count))) then
        best_color = {
          chroma = chroma,
          count = count,
          luminance = luminance,
          score = score,
          value = { r = r, g = g, b = b },
        }
      end
    end
  end

  return best_color.value
end
