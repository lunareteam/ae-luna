local pong = {}
local ball = require("game.pong.ball")
local bar = require("game.pong.bar")

function pong.initialize(screenObj, audioObj, inputObj, loaderObj, scene)
  -- Loads main objects --
  screen = screenObj
  audio = audioObj
  input = inputObj
  loader = loaderObj

  ball.initialize(bar)
  bar.initialize()
end

function pong.draw()
--{tudo o que você quiser colocar}
end

function pong.update()
--{tudo o que você quiser colocar}
end

return pong
