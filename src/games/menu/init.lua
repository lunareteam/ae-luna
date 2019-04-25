local init = {}

function init.initialize(gameObj, loaderObj, screenObj)
  game = gameObj
  loader = loaderObj
  screen = screenObj

  init.updating = false
end

function init.update()
  init.updating = true
  if love.keyboard.isDown("q") then
    loader.changeGame("pong")
  end
  init.updating = false
end

function init.draw()
  love.graphics.print("Menu - Press q to start", screen.width/2-65, screen.height/2-5)
  if game.name() == not nil then
    love.graphics.print(game.name(), screen.width/2-20, screen.height/2+5)
  end
end

return init
