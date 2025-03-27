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
  local pokemon = GetRandomPokemon(0.01)
  local lines = vim.split(pokemon, "\n")
  local height = #lines
  local width = 0

  for _, line in ipairs(lines) do
    local clean_line = RemoveAnsiCodes(line)
    local line_length = require("lua-utf8").len(clean_line)
    if line_length > width then
      width = line_length or 0
    end
  end

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
