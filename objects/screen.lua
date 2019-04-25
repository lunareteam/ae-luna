local screen = {}

function screen.initialize()
  -- Screen size --
  screen.width = love.graphics.getWidth()
  screen.height = love.graphics.getHeight()
  -- Screen mode --
  screen.fullscreen = false
  -- Game loaded --
  screen.game = nil
end

function screen.isGame()
  if screen.game == nil then
    return false
  end
  return true
end

function screen.isFullscreen()
  if screen.fullscreen == true then
    return true
  end
  return false
end

function screen.draw()
  if screen.isGame() then
    loader.draw()
  else
    menu.draw()
  end
end

function screen.update()
  -- Variables that receive constant change --
  screen.width = love.graphics.getWidth()
  screen.height = love.graphics.getHeight()
end

return screen
