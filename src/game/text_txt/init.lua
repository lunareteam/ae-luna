--[[The visual novel based part of the game]]--
-- Makes itself an object --
local vn = {}

-- Calls opbjects --
local reader = require("game.text_txt.reader")

-- Initializer function --
function vn.initialize(screenObj, audioObj, inputObj, loaderObj, scene)
  -- Loads main objects --
  screen = screenObj
  audio = audioObj
  input = inputObj
  loader = loaderObj
  alpha = 0       -- Alpha value
  pressed =0  -- Keypress limit
  fadeInTime = 0  -- Fade in time

  -- Initializes script reader --

  reader.initialize(scene)
end

-- VN's draw function --
function vn.draw()
  -- Draws text space and prints text asking for input --
  love.graphics.rectangle("line", 800*0.05, 600/2/2*3-30, 800-600*0.15, 600*0.25-600*0.25*0.1)
  love.graphics.print({{0, 255, 0, 1},"<Press Return>"}, 800-175, 600-70, 0, 1.2)

  -- Draws vn scene --
  love.graphics.print({{255,255,255,alpha},reader.scriptStr[scene]}, 800*0.07, 600/2/2*3-10, 0, 1.2)
  vn.fadeIn()
end

-- Fades text --
function vn.fadeIn()
  if love.timer.getTime() <= fadeInTime+0.35 then
    alpha = alpha+0.05
  else
    fadeInTime = love.timer.getTime()
  end
end

-- VN's update function --
function vn.update()
  -- Action to go to next scene with delay --
  if love.keyboard.isDown("return") and pressed==0 then
    -- Ends game when script ends --

    if (scene == #reader.scriptStr) then
      loader.changeGame("menu")
    elseif pressed==0 then
      reader.nextScene()    -- Goes to next scene
      alpha = 0             -- Resets alpha value
    end
    --return was pressed,so it is unable to be pressed again--
    pressed=1
  end

end

  function love.keyreleased(k)
    --if return is released, will enable to be pressed again--
    if k== "return" then
      pressed=0
    end
  end

-- Returns itself --
return vn
