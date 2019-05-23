--[[Main menu initializer]]--
-- Makes itself an object --
local menu = {}

-- Calls objects --
local options = require("game.menu.options")

-- Initializer function --
function menu.initialize(screenObj, audioObj, inputObj, loaderObj)
  -- Loads called objects --
  screen = screenObj
  audio = audioObj
  input = inputObj
  loader = loaderObj
  pressed=0
  released=0
  audio.startBGM("game/menu/bgm/menu.wav")

  options.initialize(loader, screen, input)
end

-- Menu's draw function --
function menu.draw()
  love.graphics.print("Lunare", 750/2-60, 600/2/2, 0, 3)
  options.draw()
end

-- Menu's update function --
function menu.update()

  options.update()
end

-- Returns itself --
return menu
