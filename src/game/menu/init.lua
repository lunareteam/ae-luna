--[[Main menu initializer]]--
-- Makes itself an object --
local menu = {}

-- Calls objects --
local options = require("game.menu.options")

-- Initializer function --
function menu.initialize(screenObj, audioObj, inputObj, loaderObj)
  -- Loads main objects --
  screen = screenObj
  audio = audioObj
  input = inputObj
  loader = loaderObj

  press = 0

  options.initialize(loader)
end

-- Menu's draw function --
function menu.draw()
  love.graphics.print("Lunare", 800/2-60, 600/2/2, 0, 3)
  options.draw()
end

-- Menu's update function --
function menu.update()
  options.update()
end

-- Returns itself --
return menu
