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

  ee = {}
  for line in love.filesystem.lines("game/menu/ee.txt") do
    table.insert(ee, line)
  end
  eeUsed = ee[math.random(1, #ee)]
  if eeUsed == "Coma brocollis!" then
    audio.playSFX("game/menu/sfx/brocollis.ogg")
  end

  options.initialize(loader, screen, input)
end

-- Menu's draw function --
function menu.draw() 
  love.graphics.print("Lunare", 800/2-110, 600/2/2)
  love.graphics.print(eeUsed, 800/2+20, 600/2/2+50,-0.2, 0.3)
  options.draw()
end

-- Menu's update function --
function menu.update()
  options.update()
end

-- Returns itself --
return menu
