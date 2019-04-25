local screen = {}


function screen.initialize(loaderObj, gameObj)
  loader = loaderObj
  game = gameObj
  -- Set window title --
  love.window.setTitle("Magnavox")
  -- Screen size --
  screen.width, screen.height = love.graphics.getDimensions()
  -- Screen mode --
  screen.fullscreen = false
end

function screen.setDefaultMode()
  -- Set default size --

end

function screen.setFullscreen(mode)
  love.window.setFullscreen(mode)
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
  -- Screen size --
  screen.width, screen.height = love.graphics.getDimensions()
end

return screen
