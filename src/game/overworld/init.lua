--[[Pong main file]]--
-- Makes itself an object --
local init = {}

-- Calls --

local player = require("game.overworld.player")
local warudo = require("game.overworld.warudo")

-- Initializer --
function init.initialize(screenObj, audioObj, inputObj, loaderObj)
  -- Loads called objects --
  loader = loaderObj
  screen = screenObj
  audio = audioObj
  input = inputObj

  audio.startBGM("game/pong/bgm/maintheme.ogg")

  player.initialize(screenObj, warudo, audio)
  warudo.initialize(screenObj, player)
end

-- Drawer --
function init.draw()
  player.draw()
  warudo.draw()
end

-- Pong Updater --
function init.update()

  player.update()
  warudo.update()

  if input.getKey("return") then
    loader.changeGame("pong")
  end
end

-- Returns itself --
return init
