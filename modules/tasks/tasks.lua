function OverseerRunAndOpen()
  local overseer = require("overseer")
  overseer.run_template({}, function(task)
    if task then
      overseer.open()
    end
  end)
end
