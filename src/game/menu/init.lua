--[[Main menu initializer]]--
-- Makes itself an object --
local menu = {}

local mainOpt = require("game.menu.mainOpt")

-- Initializer function --
function menu.initialize(screenObj, audioObj, inputObj, loaderObj)
  -- Loads main objects --
  screen = screenObj
  audio = audioObj
  input = inputObj
  loader = loaderObj

  press = 0

  mainOpt.initialize(loader)
end

-- Menu's draw function --
function menu.draw()
  love.graphics.print("Lunare", 800/2-60, 600/2/2, 0, 3)
  mainOpt.draw()
end

-- Menu's update function --
function menu.update()
  mainOpt.update()
end

-- Returns itself --
return menu
