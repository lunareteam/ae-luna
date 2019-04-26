-- Makes the method --
local init = {}

-- Calls --
local baston = require("games.pong.baston")
local ball = require("games.pong.ball")
local player = require("games.pong.player")

-- Initializer --
function init.initialize(gameObj, loaderObj, screenObj)
  game = gameObj
  loader = loaderObj
  screen = screenObj

  player.initialize()
  baston.initialize(screenObj, player)
  ball.initialize(screenObj, baston, player)
end

-- Drawer --
function init.draw()
  baston.draw()
  ball.draw()
  player.draw()
end

function init.update()
  if love.keyboard.isDown("escape") then
    loader.changeGame("menu")
  end
  baston.update()
  ball.update()
  player.update()
end

return init
