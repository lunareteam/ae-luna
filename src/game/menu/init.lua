--[[Main menu initializer]]--
-- Makes itself an object --
local menu = {}

-- Initializer function --
function menu.initialize(screenObj, audioObj, inputObj, loaderObj)
  -- Loads main objects --
  screen = screenObj
  audio = audioObj
  input = inputObj
  loader = loaderObj

  press = 0
end

-- Menu's draw function --
function menu.draw()
  love.graphics.print("Lunare", 800/2-60, 600/2/2, 0, 3)
end

-- Menu's update function --
function menu.update()
  if love.keyboard.isDown("return") and love.timer.getTime() >= press+0.5 then
    loader.changeGame("text_txt", 1)
    press = love.timer.getTime()
  end
end

-- Returns itself --
return menu
