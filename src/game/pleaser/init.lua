--[[The visual novel based part of the game]]--
-- Makes itself an object --
local vn = {}

-- Calls opbjects --
local reader = require("game.pleaser.reader")

-- Initializer function --
function vn.initialize(screenObj, audioObj, inputObj, loaderObj, scene)
  -- Loads main objects --
  screen = screenObj
  audio = audioObj
  input = inputObj
  loader = loaderObj

  press = 0

  reader.initialize(scene)
end

-- VN's draw function --
function vn.draw()
  -- Draws text space and prints text asking for input --
  love.graphics.rectangle("line", 800*0.05, 600/2/2*3-30, 800-600*0.15, 600*0.25-600*0.25*0.1)
  love.graphics.print({{0, 255, 0, 1},"<Press Return>"}, 800-175, 600-70, 0, 1.2)

  -- Draws vn scene --
  reader.draw()
end

-- VN's update function --
function vn.update()
  if love.keyboard.isDown("return") and love.timer.getTime() >= press+1 then
    reader.nextScene()
    press = love.timer.getTime()
  end
end

return vn
