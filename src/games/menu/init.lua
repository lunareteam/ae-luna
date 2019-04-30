local init = {}
local options = require("games.menu.options")

function init.initialize(gameObj, loaderObj, screenObj)
  game = gameObj
  loader = loaderObj
  screen = screenObj
  options.initialize(loader)
end

function init.update()
  options.update()
end

function init.draw()
  love.graphics.print("MES - Magnavox Entertainment System", screen.width/2-365, screen.height/2/2, 0, 3)
  options.draw()
end

return init
