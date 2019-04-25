local screen = {}


function screen.initialize(loaderObj, gameObj)
  loader = loaderObj
  game = gameObj
  screen.setDefaultMode()
  -- Set window title --
  love.window.setTitle("Magnavox")
  -- Screen size --
  screen.width, screen.height = love.graphics.getDimensions()
  -- Screen mode --
  screen.fullscreen = false
end

function screen.setDefaultMode()
  -- Set default size --
  love.window.setMode(640, 480)
end

function screen.setFullscreen(mode)
  if screen.isFullscreen() then
    love.window.setFullscreen(mode)
    screen.setDefaultMode()
  else
    love.window.setFullscreen(mode)
  end
end

function screen.isGame()
  if game.name() == nil then
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
  loader.draw(screen)
end

function screen.update()
  -- Variables that receive constant change --
  screen.width = love.graphics.getWidth()
  screen.height = love.graphics.getHeight()
end

return screen
