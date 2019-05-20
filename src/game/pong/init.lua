--[[Pong main file]]--
-- Makes itself an object --
local init = {}

-- Calls --
local bar = require("game.pong.bar")
local ball = require("game.pong.ball")
local player = require("game.pong.player")

-- Initializer --
function init.initialize(screenObj, audioObj, inputObj, loaderObj)
  -- Loads called objects --
  loader = loaderObj
  screen = screenObj
  audio = audioObj
  input = inputObj

  audio.startBGM("game/pong/bgm/maintheme.ogg")

  player.initialize(screen, bar, ball)
  bar.initialize(screenObj, player)
  ball.initialize(screenObj, bar, player, audio)
end

-- Drawer --
function init.draw()
  bar.draw()
  ball.draw()
  player.draw()
end

function init.update()
  if player.score1 == 5 then
    audio.stopBGM()
    loader.changeGame("text_txt", 2)
  elseif player.score2 == 5 then
    audio.stopBGM()
    loader.gameover()
  end

  bar.update()
  ball.update()
  player.update()
end

return init
