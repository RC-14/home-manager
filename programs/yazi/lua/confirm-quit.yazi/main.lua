local count = ya.sync(function() return #cx.tabs end)

local function entry()
  if count() < 2 then
    return ya.emit("quit", {})
  end

  local yes = ya.confirm {
    pos = { "center", w = 40, h = 5 },
    title = "Quit?",
    body = ui.Text("There are still multiple tabs open."):wrap(ui.Wrap.YES),
  }
  if yes then
    ya.emit("quit", {})
  end
end

return { entry = entry }
