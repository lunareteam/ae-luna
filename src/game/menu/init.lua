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
end

-- Menu's draw function --
function menu.draw()
  love.graphics.print("Lunare", 800/2-60, 600/2/2, 0, 3)
end

-- Menu's update function --
function menu.update()
  if love.keyboard.isDown("return") then
    loader.changeGame("pleaser", 0)
  end
end

return menu
