local loader ={}

function loader.initialize(gameObj, screenObj)
  screen = screenObj
  game = gameObj
  loader.changeGame("menu")
end

function loader.changeGame(name)
  game.newGame(name)
  init = nil
  init = require(game.path())
  init.initialize(game, loader, screen)
end

function loader.draw()
  init.draw()
end

function loader.update()
  init.update()
end

return loader
