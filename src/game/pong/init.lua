-- Makes the method --
local init = {}

-- Calls --
local bar = require("game.pong.bar")
local ball = require("game.pong.ball")
local player = require("game.pong.player")

-- Initializer --
function init.initialize(screenObj, audioObj, inputObj, loaderObj)
  loader = loaderObj
  screen = screenObj
  audio = audioObj
  input = inputObj

  player.initialize()
  bar.initialize(screenObj, player)
  ball.initialize(screenObj, bar, player)
end

-- Drawer --
function init.draw()
  bar.draw()
  ball.draw()
  player.draw()
end

function init.update()
  bar.update()
  ball.update()
  player.update()
end

return init
