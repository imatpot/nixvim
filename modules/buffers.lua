function CountBuffersByType(loaded_only)
  loaded_only = loaded_only == nil and true or loaded_only
  local buffer_types = vim.api.nvim_list_bufs()
  local counts = { normal = 0 }

  for _, buf in ipairs(buffer_types) do
    if not loaded_only or vim.api.nvim_buf_is_loaded(buf) then
      local buf_type = vim.api.nvim_buf_get_option(buf, "buftype")
      buf_type = buf_type ~= "" and buf_type or "normal"
      counts[buf_type] = (counts[buf_type] or 0) + 1
    end
  end

  return counts
end

function CloseBuffer()
  local counts = CountBuffersByType()

  if counts.normal <= 1 then
    vim.api.nvim_exec(":q", true)
  else
    vim.api.nvim_exec(":bprevious | bdelete #", true)
  end
end
