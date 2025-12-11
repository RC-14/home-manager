--[[
################
# Plugin Setup #
################
]]--

-- Full Border
require("full-border"):setup { type = ui.Border.ROUNDED }

-- Git
-- require("git"):setup()

--[[
########################
# Custom functionality #
########################
]]--

-- User:Group in status line
Status:children_add(function()
  local h = cx.active.current.hovered
  if not h or ya.target_family() ~= "unix" then
    return ""
  end

  return ui.Line {
    ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
    ":",
    ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
    " ",
  }
end, 500, Status.RIGHT)

-- Just here because returning nothing makes Yazi throw an error on launch
return { }
