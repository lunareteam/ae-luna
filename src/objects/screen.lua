local screen = {}

function screen.initialize(loaderObj)
  loader = loaderObj
  screen.getDimensions()
end

function screen.draw()
  love.graphics.rectangle("line", 0, 0, 800, 600)
end

function screen.getDimensions()
  screen.width, screen.height = love.graphics.getDimensions()
end

function screen.update()
  love.graphics.scale(screen.width, screen.height)
  screen.getDimensions()
  love.window.setTitle(loader.game)
end

return screen
