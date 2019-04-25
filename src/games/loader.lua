local loader ={}

local init = require("games.menu.init")

function loader.initialize(gameObj, screenObj)
  screen = screenObj
  game = gameObj
  init.initialize(game, loader, screen)
end

function loader.changeGame(name)
  game.newGame(name)
  init = require(game.path())
  init.initialize(game, loader)
end

function loader.draw()
  if not loader.updating then
    init.draw(screen)
  end
end

function loader.update()
  love.graphics.print("Working", screen.width/2-20, screen.height/2+5)
  init.update()
end

return loader
